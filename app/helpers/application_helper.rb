module ApplicationHelper
  def dynamic_page_title(*args)
    return ["Full Boat", ((args << [@section, @user].compact.first.to_s) rescue nil)].flatten.delete_if{|x| x.blank?}.join(" / ")
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
  
  def navigation_tab(name, url, options = {})
    section = name
    content_tag(:li, link_to(name, url), {:class => @section == section ? 'current' : nil}.merge(options))
  end
  
  def br_tag
    tag("br")
  end
  
  def placeholder_album_cover(options={})
    image_tag("albums/#{rand(7)}.jpg", {:alt => "Placeholder"}.update(options)) +
    (options[:jewelcase] ? content_tag(:span, nil, :class => 'jewelcase') : '')
  end
  

  def schedules_drop_down
    content_tag(:select,
                options_for_select(Schedule.find(:all, :order => "starts_at DESC").collect{|s|
                                    [h(s), schedule_path(s)]}, (schedule_path(@schedule) rescue nil)),
                :onchange => "location=''+this.options[this.selectedIndex].value;")
  end
  
  # TODO: Refactor into template-based method using lighter markup language
  def hcard(record, options = {})
    h = {}  
    case klass = record.class.to_s
    when "User"
      user = record
      h[:fn]    = user.name
      h[:tel]   = user.phone
      h[:email] = user.email
      h[:url]   = user_url(user)
    when "Label"
      label = record
      h[:org]   = true
      h[:fn]    = label.name
      h[:tel]   = label.phone
      h[:email] = label.email
      h[:url]   = label_url(label)
    when "Artist"
      return ""
    else
      raise "Record of type '#{klass}' cannot be represented as hCard"
    end
    
    content_tag(:div,
      (h[:org] ? content_tag(:span, link_to(content_tag(:span, h[:fn], :class => 'fn org'), 
                                            h[:url], :class => 'url')) :
                content_tag(:span, link_to([content_tag(:span, h[:fn].first, :class => 'given-name'), 
                                            content_tag(:span, h[:fn].last, :class => 'family-name')].join(' '), 
                                            h[:url], :class => 'url'), 
                            :class => "fn n")) +
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