require "digest/sha1"
class User < ActiveRecord::Base
  validates_uniqueness_of :username
  validates_length_of :username, :minimum => 5
  validates_length_of :password, :minimum => 5, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_presence_of :username, :full_name
  before_save :hash_password
  
  attr_accessor :password
  
  def self.authenticate(username, password)
    find_by_username_and_password_hash(username, hash_password(password))
  end
  
  private
  
  def self.hash_password(password)
    Digest::SHA1.hexdigest("/-#{password}-/")
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