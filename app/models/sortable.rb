module Sortable
  def self.included(base)
    base.class_eval do
      extend ClassMethods

      after_create :set_default_position
      private
        def set_default_position
          self.update_column(:position, id)
        end
    end
  end

  module ClassMethods
    def default_order
      order(default_order_str)
    end

    def default_order_str
      'position ASC'
    end
  end
end
