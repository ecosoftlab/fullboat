module ApplicationHelper
  def dynamic_page_title(*args)
    return ["WRCT", ((args << [@user, @page].compact.first.to_s) rescue nil)].flatten.delete_if{|x| x.blank?}.join(" / ")
  end
    
  def loading_indicator(id = nil, options = {})
    content_tag(:span,
      image_tag("spinner.gif", { :alt => "Loading...", 
                                 :size => '16x16'       }) +
      (options[:text] || ""),
      { :style => "display:none;",
        :class => "loading-indicator", 
        :id => id.nil? ? "loading-indicator" : "#{id}-loading-indicator"}.update(options))
  end
  
  def navigation_tab(name, url)
    content_tag(:li, link_to(name, url), :class => current_page?(url) ? 'current' : nil)
  end
  
  def br_tag
    tag("br")
  end
end