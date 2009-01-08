ActiveRecord::Base.class_eval do
  # person.dom_id #-> "person-5"
  # new_person.dom_id #-> "person-new"
  # new_person.dom_id(:bare) #-> "new"
  # person.dom_id(:person_name) #-> "person-name-5"
  def dom_id(prefix=nil)
    display_id = new_record? ? "new" : id
    prefix ||= self.class.name.underscore
    prefix != :bare ? "#{prefix.to_s.dasherize}-#{display_id}" : display_id
  end
end

# Time.now.to_ordinalized_s :long
# => "February 28th, 2006 21:10"
module ActiveSupport::CoreExtensions::Time::Conversions
  def to_ordinalized_s(format = :default)
    format = ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS[format] 
    return to_default_s if format.nil?
    strftime(format.gsub(/%d/, '_%d_')).gsub(/_(\d+)_/) { |s| s.to_i.ordinalize }
  end
  
  def to_s(format = :default)
    format = ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS[format] 
    return to_default_s if format.nil?
    strftime(format.gsub(/%d/, '_%d_')).gsub(/_(\d+)_/) { |s| s.to_i }
  end
end

class String
  def truncate(length = 30, truncate_string = "...")
    l = length - truncate_string.chars.length
    chars = self.chars
    (chars.length > length ? chars[0...l] + truncate_string : self).to_s
  end
end

# fix Tempfile to work with mogrify by removing filename extension
class Tempfile
  def make_tmpname(basename, n)
    # force tempfile to use basename's extension if provided
    ext = File::extname(basename)
    # force hyphens instead of periods in name
    sprintf('%s%d-%d%s', File::basename(basename, ext), $$, n, ext)
  end
end


ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.update \
  :standard  => '%B %d, %Y @ %I:%M %p',
  :stub      => '%B %d',
  :time_only => '%I:%M %p',
  :plain     => '%B %d %I:%M %p',
  :short     => '%d %b %Y',
  :md        => '%m/%d',
  :mdy       => '%B %d, %Y',
  :my        => '%B %Y',
  :dmy       => '%d %B %Y',
  :w3c       => '%Y-%m-%dT%H:%M:%S+00:00',
  :rss       => '%a, %d %b %Y %H:%M:%S %z',
  :atom      => '%Y-%m-%dT%H:%M:%S-08:00',
  :filename  => '%Y%m%d%H%M' 
  
  
class Date
  DAYS = {'sunday' => 0, 'monday' => 1, 'tuesday' => 2, 'wednesday' => 3, 'thursday' => 4, 'friday' => 5, 'saturday' => 6}
  cattr_accessor :days
  
  def to_s(format = :default)
    self.to_time.to_s(format)
  end
  
  def to_ordinalized_s(format = :default)
    self.to_time.to_ordinalized_s(format)
  end
end