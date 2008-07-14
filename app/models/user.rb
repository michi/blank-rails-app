require "digest/sha1"
class User < ActiveRecord::Base
  validates_uniqueness_of :username, :email
  validates_length_of :username, :minimum => 5
  validates_length_of :password, :minimum => 5, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_presence_of :username, :full_name
  validates_format_of :email, :with => /^[\w]+@[\w]+\.[\w]{1,5}$/i
  validates_each(:password) do |record, attribute, value|
    record.errors.add(attribute, 'can not be the same as the username') if value == record.username
  end
  before_save :hash_password
  
  attr_accessor :password
  attr_readonly :username
  
  def self.authenticate(username, password)
    find_by_username_and_password_hash(username, hash_password(password)) || false
  end
  
  def self.find_for_password_reset(query)
    find(:first, :conditions => ["username = :query OR email = :query", {:query => query}])
  end
  
  def reset_password!
    new_password = self.class.generate_password
    self.password = new_password
    save!
    send_new_password_notification(new_password)
  end
  
  private
  
  def self.hash_password(password)
    Digest::SHA1.hexdigest("/-#{password}-/")
  end
  
  def self.generate_password
    Digest::SHA1.hexdigest(Time.now.to_s.split(//).sort_by {rand}.join)[1..(5..7).to_a.rand]
  end
  
  def hash_password
    if password_required?
      self.password_hash = self.class.hash_password(self.password)
    end
  end
  
  def password_required?
    new_record? || !self.password.blank?
  end
  
  def send_new_password_notification(new_password)
    Mailer.deliver_new_password_notification(self, new_password)
  end
end