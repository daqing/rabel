# configure custom format
#ActionController::Responder.class_eval do
#  alias :to_mobile :to_html
#end

ActiveRecord::Base.class_eval <<-CODE
  def html_id
    self.class.name.downcase + "_" + self.id.to_s
  end
CODE

