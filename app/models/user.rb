require "digest/sha1"
class User < ActiveRecord::Base
  validates_uniqueness_of :username, :email
  validates_length_of :username, :minimum => 5
  validates_length_of :password, :minimum => 5, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_presence_of :username, :full_name
  validates_format_of :email, :with => /^[\w]+@[\w]+\.[\w]{1,5}$/i
  before_save :hash_password
  
  attr_accessor :password
  
  def self.authenticate(username, password)
    find_by_username_and_password_hash(username, hash_password(password))
  end
  
  def reset_password!
    new_password = generate_password
  end
  
  private
  
  def self.hash_password(password)
    Digest::SHA1.hexdigest("/-#{password}-/")
  end
  
  def self.generate_password
    Digest::SHA1.hexdigest("{ -- #{Time.now.to_s} -- }")[1..(5..7).to_a.rand]
  end
  
  def hash_password
    if password_required?
      self.password_hash = self.class.hash_password(self.password)
      self.password = nil
    end
  end
  
  def password_required?
    new_record? || !self.password.blank?
  end
end