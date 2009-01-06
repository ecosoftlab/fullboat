# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when 
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.1.0' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.load_paths += %W[
    #{RAILS_ROOT}/app/models/aggregations
    #{RAILS_ROOT}/app/models/notifiers
    #{RAILS_ROOT}/app/models/observers
    #{RAILS_ROOT}/app/models/webservices
  ]
  
  config.action_controller.session = { :session_key => "_wrct_session", 
                                       :secret      => "lYcY0aHucGRH8Ehf43BqxezUVkW4S2dB5LtbaYVw" }
  config.active_record.observers   = []            
end

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

  # Write a fixture file for testing
  def self.to_fixture(fixture_path = nil)
    File.open(File.expand_path(fixture_path || "test/fixtures/#{table_name}.yml", RAILS_ROOT), 'w') do |out|
      YAML.dump find(:all).inject({}) { |hsh, record| hsh.merge(record.id => record.attributes) }, out
    end
  end

  def referenced_cache_key
    "[#{[id, self.class.name] * ':'}]"
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
end

ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.update \
  :standard  => '%B %d, %Y @ %I:%M %p',
  :stub      => '%B %d',
  :time_only => '%I:%M %p',
  :plain     => '%B %d %I:%M %p',
  :mdy       => '%B %d, %Y',
  :my        => '%m / %Y',
  :dmy       => '%d %B %Y',
  :w3c       => '%Y-%m-%dT%H:%M:%S+00:00',
  :rss       => '%a, %d %b %Y %H:%M:%S %z',
  :atom      => '%Y-%m-%dT%H:%M:%S-08:00'


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

require 'icalendar'

Mime::Type.register "text/html", :enlarged


gem 'yahoo-music'
require 'yahoo-music'
Yahoo::Music.app_id = "QwqOzR_V34HHT7ZTo5NS0Cw.5fPA4HB0UbB5COtCTJDku.AxFNpMvBmUpTNM5WpBZHglQSg-"

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