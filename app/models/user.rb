
# Schema as of June 12, 2006 15:45 (schema version 7)
#
# Table name: users
#
# create_table "users", :force => true do |t|
#    t.string  "name"
#    t.string  "contact_name",                                    :null => false
#    t.string  "company_name",                                    :null => false
#    t.string  "email",                                           :null => false
#    t.integer "company_id",      :limit => 8,                    :null => false
#    t.string  "hashed_password"
#    t.string  "salt"
#    t.boolean "admin",                                           :null => false
#    t.boolean "company_admin",                :default => false, :null => false
#    t.integer "user_type_id",    :limit => 8,                    :null => false
#    t.integer "status_id",       :limit => 8,                    :null => false
#  end

require 'digest/sha1'

#START:validate
class User < ActiveRecord::Base
  has_many :demands
  has_many :offers
  belongs_to :user_type
  belongs_to :company
  belongs_to :status
  
  validates_presence_of     :contact_name, :name, :email, :user_type_id, :company_id, :password
                            
  validates_uniqueness_of   :name
  
 
  attr_accessor :password_confirmation
  validates_confirmation_of :password


    RE_EMAIL_NAME   = '[\w\.%\+\-]+'                          # what you actually see in practice
    #RE_EMAIL_NAME   = '0-9A-Z!#\$%\&\'\*\+_/=\?^\-`\{|\}~\.' # technically allowed by RFC-2822
    RE_DOMAIN_HEAD  = '(?:[A-Z0-9\-]+\.)+'
    RE_DOMAIN_TLD   = '(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)'
    RE_EMAIL_OK     = /\A#{RE_EMAIL_NAME}@#{RE_DOMAIN_HEAD}#{RE_DOMAIN_TLD}\z/i
    MSG_EMAIL_BAD   = "formati düzgün olmalıdır"

    validates_length_of :email, :within => 6..100
    validates_format_of :email, :with => RE_EMAIL_OK, :message => MSG_EMAIL_BAD

  def validate
    errors.add_to_base("Missing password") if hashed_password.blank?
  end
#END:validate

  def initialize(*params)
    super(*params)
    self.status_id = Status::User::VALPENDING
  end
  
  #START:login
  def self.authenticate(name, password)
    user = self.find_by_name(name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end
  #END:login

  def password_valid? (pwd)
    expected_password = User.encrypted_password(pwd, self.salt)
    self.hashed_password == expected_password ? :true : :false
  end
  
  # 'password' is a virtual attribute
  #START:accessors
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  #END:accessors

  #START:after_destroy
  def after_destroy
    if User.count.zero?
      raise "Can't delete last user"
    end
  end     
  #END:after_destroy

  def email_with_name
    self.email
  end

  HUMANIZED_ATTRIBUTES = {
    :name => "kullanıcı adı",
    :contact_name => "adı soyadı",
    :company_name => "firma adı",
    :company_id => "firma adı",
    :email => "e-posta",
    :user_type_id => "kullanıcı tipi",
    :status_id => "durum",
    :admin => "yönetici",
    :company_admin => "firma yöneticisi",
    :password => "Şifre"
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym].capitalize || super
  end
  
  private
  
  #START:create_new_salt
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  #END:create_new_salt
  
  #START:encrypted_password
  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
  #END:encrypted_password
#START:validate  
end
#END:validate
