module Rabel
  module ActiveCache
    def self.included(base)
      base.class_eval do
        extend ClassMethods
      end
    end

    def cached_assoc_collection(assoc, order, limit)
      ts  = send(assoc).select('updated_at').order('updated_at DESC').first.try(:updated_at)
      return Rabel::Model::EMPTY_DATASET unless ts.present?
      total = send(assoc).count
      cache_keys = [
        self.class.model_name.collection,
        self.id,
        assoc,
        order,
        limit,
        ts,
        total
      ]

      Rails.cache.fetch(cache_keys.join('/')) do
        send(assoc).order(order).limit(limit).all
      end
    end

    def cached_assoc_pagination(assoc, current_page, per_page, order_column, order_type=Rabel::Model::ORDER_DESC)
      raise ArgumentError, "Invalid order type: #{order_type}" unless Rabel::Model::ORDER_SPEC.include?(order_type)

      ts = send(assoc).select("updated_at").order("updated_at DESC").first.try(:updated_at)
      return Kaminari.paginate_array(Rabel::Model::EMPTY_DATASET).page(0) unless ts.present?

      total = send(assoc).count
      cache_keys = [
        self.class.model_name.collection,
        id,
        assoc,
        "#{current_page}:#{per_page}",
        "#{order_column}:#{order_type}",
        "#{total}-#{ts}"
      ]

      result = Rails.cache.fetch(cache_keys.join('/')) do
        send(assoc).order("#{order_column} #{order_type}").page(current_page).per(per_page).all
      end

      Kaminari.paginate_array(result, :total_count => total).page(current_page).per(per_page)
    end

    def cached_assoc_object(assoc)
      target_class = assoc.to_s.camelize.constantize
      target_class.find_cached(self.send("#{assoc}_id"))
    end

    module ClassMethods
      def find_cached(id)
        ts = select('updated_at').where(:id => id).first.try(:updated_at)
        raise ActiveRecord::RecordNotFound, "Couldn't find #{model_name} with id=#{id}" unless ts.present?

        Rails.cache.fetch("#{model_name.collection}/#{id}-#{ts}") do
          find(id)
        end
      end

      def find_by_attr_cached(key, value, where_options={})
        where_options.reverse_merge!(key => value)
        ts = select('updated_at').where(where_options).first.try(:updated_at)
        return nil unless ts.present?

        cache_keys = [model_name.collection]
        cache_keys += where_options.map {|k, v| "#{k}:#{v}"}
        cache_keys << ts

        Rails.cache.fetch(cache_keys.join('/')) do
          where(key => value).first
        end
      end

      def find_by_attr_cached!(key, value, where_options={})
        result = find_by_attr_cached(key, value, where_options)
        raise ActiveRecord::RecordNotFound, "Couldn't find #{model_name} with #{key}=#{value}" unless result.present?

        result
      end

      def cached_pagination(page, per_page, order_column, order_type=Rabel::Model::ORDER_DESC)
        raise ArgumentError, "Invalid order type: #{order_type}" unless Rabel::Model::ORDER_SPEC.include?(order_type)
        ts = select(order_column).order("#{order_column} DESC").first.try(order_column.to_sym)
        return Kaminari.paginate_array(Rabel::Model::EMPTY_DATASET).page(0) unless ts.present?

        total = self.count
        cache_keys = [
          self.model_name.collection,
          "#{page}:#{per_page}",
          "#{order_column}:#{order_type}",
          "#{total}-#{ts}",
        ]

        result = Rails.cache.fetch(cache_keys.join('/')) do
          order("#{order_column} #{order_type}").page(page).per(per_page).all
        end

        Kaminari.paginate_array(result, :total_count => total).page(page).per(per_page)
      end

      def cached_count
        Rails.cache.fetch("#{self.model_name.collection}/count", :expires_in => 5.minutes) do
          self.count
        end
      end

      def cached_all(order_str='')
        ts = select('updated_at').order('updated_at DESC').first.try(:updated_at)
        return Rabel::Model::EMPTY_DATASET unless ts.present?
        Rails.cache.fetch("#{self.model_name.collection}/all-#{ts}") do
          self.order(order_str).all
        end
      end
    end
  end
end
