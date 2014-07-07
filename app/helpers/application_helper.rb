module ApplicationHelper
  def content_nav_link_to(name ,path)
    options = {}
    options[:class] = 'active' if current_page?(path)
    content_tag(:li, options) { link_to name, path }
  end
end
