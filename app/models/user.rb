require 'digest/sha1'
class User < ActiveRecord::Base
  @@per_page = 30
  cattr_reader :status_values, :per_page
  
  searchify :login, :first_name, :last_name, :dj_name
  
  has_attached_file :avatar, :styles => { :large => "230x230>", :thumb => "64x64#", :tiny => '24x24' },
                             :default_style => :thumb,
                             :default_url => '/images/missing-avatar.jpg'
                             
  acts_as_state_machine :initial => :active, :column => 'status'
  
  state :active        # TODO Add notifications
  state :inactive      # TODO Add notifications
  state :banned        # TODO Add notifications
  
  event :activate do
    transitions :from => :inactive, :to => :active
  end

  event :deactivate do
    transitions :from => :active, :to => :inactive
  end
  
  event :ban do
    transitions :from => :active,    :to => :banned
    transitions :from => :inactive,  :to => :banned
  end
  
    
  has_and_belongs_to_many :roles
  
  has_and_belongs_to_many :programs
  has_many :playlists
  
  has_many :reviews
  
  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_presence_of     :login, :email, :name
  validates_presence_of     :password,                    :if => :password_required?
  validates_presence_of     :password_confirmation,       :if => :password_required?
  validates_confirmation_of :password,                    :if => :password_required?
  validates_length_of       :password,  :within => 4..40, :if => :password_required?
  validates_length_of       :login,     :within => 3..40
  validates_length_of       :email,     :within => 3..100
  validates_uniqueness_of   :login,     :email, :case_sensitive => false
  
  validates_format_of       :login, :with => /^[\w\d]+$/
  
  before_save               :encrypt_password
  before_create             :make_activation_code
  
  composed_of :name, 
              :class_name => "Name", 
              :mapping => [ # database    ruby 
                          [ :first_name,  :first    ], 
                          [ :last_name,   :last     ]]
  
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation,
                  :first_name, :last_name, :dj_name
  attr_accessible :avatar #, :avatar_file_name, :avatar_content_type, :avatar_file_size
  
  def to_s
    self.name.to_s
  end
  
  def to_param
    return "#{self.id}-#{self.login}"
  end
  
  def <=>(person)
    self.name <=> person.name
  end
  
  def self.<=>(klass)
    self.to_s <=> klass.to_s
  end
  
  def email_address_with_name
    "\"#{self.name.to_s}\" <#{self.email}>"
  end
  
  def name=(fullname)
    name = fullname.split(/\s/)
    self[:last_name], self[:first_name] = name.pop, name.join(" ")
  end
  
  def self.find_by_name(name)
    p = Person.new(:name => name)
    find_by_first_name_and_last_name(p.name.first, p.name.last)
  end
  
  # Activates the user in the database.
  def activate
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  def activated?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end
  
  def active?
    self.status == :active
  end
  
  def inactive?
    self.status == :inactive
  end
  
  def banned?
    self.status == :banned
  end
  
  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find :first, :conditions => ['login = ? and activated_at IS NOT NULL', login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

protected

  def encrypt_password
    return if password.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
    self.crypted_password = encrypt(password)
  end
  
  def password_required?
    crypted_password.blank? || !password.blank?
  end
  
  def make_activation_code
    self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end 
end

# Class instances to satisfy Type column

class Undergraduate < User; end
class Graduate      < User; end
class Alumni        < User; end
class Community     < User; end
class Faculty       < User; end
class Staff         < User; end