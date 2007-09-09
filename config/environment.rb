# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when 
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '1.2.3' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.load_paths += %W[
    #{RAILS_ROOT}/app/models/aggregations
    #{RAILS_ROOT}/app/models/people
    #{RAILS_ROOT}/app/models/splash_media
  ]
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
  
  def self.find_from_ids_with_coercion(ids, options)
    find_from_ids_without_coercion(ids.collect(&:to_i), options)
  end

  class << self
    alias_method :find_from_ids_without_coercion, :find_from_ids
    alias_method :find_from_ids, :find_from_ids_with_coercion
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
  :my        => '%B %Y',
  :dmy       => '%d %B %Y',
  :w3c       => '%Y-%m-%dT%H:%M:%S+00:00',
  :rss       => '%a, %d %b %Y %H:%M:%S %z',
  :atom      => '%Y-%m-%dT%H:%M:%S-08:00'
  