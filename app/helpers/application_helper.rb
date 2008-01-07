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
  
  def icon(name, format = 'png')
    image_tag("icon_#{name}.#{format}", :size => '16x16', :alt => name.capitalize)
  end
  
  def hcard(record, options = {})
    h = {}  
    case klass = record.class.to_s
    when "User"
      user = record
      h[:fn]    = user.name
      h[:tel]   = user.phone
      h[:email] = user.email
      h[:url]   = user_url(user)
    else
      raise "Record of type '#{klass}' cannot be represented as hCard"
    end
    
    content_tag(:div,
      content_tag(:span, link_to([content_tag(:span, h[:fn].first, :class => 'given-name'), 
                                  content_tag(:span, h[:fn].last, :class => 'family-name')].join(' '), 
                                  h[:url], :class => 'url'), 
      :class => 'fn n') +
      content_tag(:span, 
        content_tag(:span, 'work', :class => 'type hide') +
        content_tag(:span, number_to_phone(h[:tel]), :class => 'value'),
      :class => 'tel') +
      content_tag(:span, 
        content_tag(:span, 'work', :class => 'type hide') +
        mail_to(h[:email], h[:email], :encode => :javascript, :class => 'value'), 
      :class => 'email'),
    :class => ['vcard', options[:class]].join(' '))
  end
  
  alias_method :vcard, :hcard
end