module BootstrapHelper
  def current_nav(item)
    @current_nav_item = item
  end

  def nav_item(title, path, options={})
    css_class = (title == @current_nav_item) ? 'active' : ''
    options[:class] ||= 'top'
    content_tag(:li, link_to(title, path, options), :class => css_class)
  end
end
