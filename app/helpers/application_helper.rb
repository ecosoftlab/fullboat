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
  
  def jewelcase(album, options = {})
    image_url = (album.kind_of?(Album) ? album.cover.url : album) || "missing-cover.gif"
    content_tag(:div, image_tag(image_url, options) + content_tag(:span, nil) + "&nbsp;",  :class => 'jewelcase')
  end
  
  def status_flag(album)
    image_tag("flags/#{album.status.downcase}.png", :class => 'status-flag') if album.status && album.status != 'Library'
  end
  
  def url_for_last_fm(record)
    parameters = case record
                 when Artist : [record]
                 when Album  : [record.artist, record]
                 end
    return "http://www.last.fm/music/" + parameters.collect{|s| s.to_s.gsub(/\s+/, '+')}.join('/')
  end

  def schedules_drop_down
    content_tag(:select,
                options_for_select(Schedule.find(:all).collect{|s|
                                    [h(s), schedule_path(s)]}, (schedule_path(@schedule) rescue nil)),
                :onchange => "location=''+this.options[this.selectedIndex].value;")
  end
  
  # TODO: Refactor into template-based method using lighter markup language
  def hcard(record, options = {})
    h = {}  
    case record
    when User
      user = record
      h[:fn]    = user.name
      h[:tel]   = user.phone
      h[:email] = user.email
      h[:url]   = user_url(user)
    when Label
      label = record
      h[:org]   = true
      h[:fn]    = label.name
      h[:tel]   = label.phone
      h[:email] = label.email
      h[:url]   = label_url(label)
    when Artist
      return ""
    else
      raise "Record of type '#{record.class}' cannot be represented as hCard"
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
  
  
  def hreview(record, options = {})
    h = {}
    case record
    when Review
      h[:fn]          = record.to_s
      h[:url]         = album_url(record.album)
      h[:img]         = record.album.cover.url
      h[:dtreviewed]  = record.created_at
      h[:description] = record.body
      h[:reviewer]    = hcard(record.user)
    when Album
      return nil if record.review.nil?
      h[:fn]          = record.review.to_s
      h[:url]         = album_url(record)
      h[:img]         = record.cover.url
      h[:dtreviewed]  = record.review.created_at
      h[:description] = record.review.body
      h[:reviewer]    = hcard(record.review.user)
    end
    
    content_tag(:div,
      content_tag(:span, 
        content_tag(:span, h[:fn], :class => 'fn') +
        link_to(h[:url], h[:url], :class => 'url') +
        image_tag(h[:img], :class => 'photo')
      ) +
      content_tag(:span, 'product', :class => 'type') + 
      link_to(h[:url], h[:url], :class => 'permalink', :rel => 'bookmark') + 
      content_tag(:abbr, h[:dtreviewed], :title => h[:dtreviewed].to_s(:w3c), :class => 'dtreviewed') + 
      content_tag(:p, h[:description], :class => 'description') +
      content_tag(:div, h[:reviewer], :class => 'reviewer'),
    :class => ['hreview', options[:class]].join(' '))
  end
end