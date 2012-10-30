# configure custom format
ActionController::Responder.class_eval do
  alias :to_mobile :to_html
end

ActiveRecord::Base.class_eval <<-CODE
  def html_id
    self.class.name.downcase + "_" + self.id.to_s
  end
CODE

Array.class_eval do
  # Make an Array ready to be used by Kaminari's paginate helper
  #
  # the paginate view helper will look for three reader methods,
  # so we define as below
  def pagination_ready(current_page, total_pages, per_page)
    self.instance_eval <<-CODE
      def current_page
        #{current_page}
      end

      def num_pages
        #{total_pages}
      end

      def limit_value
        #{per_page}
      end
    CODE
  end
end
