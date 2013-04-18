# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
  
  before_save { |user| user.email = email.downcase } # action to be done before saving to DB
  before_save :create_remember_token # call the method create_remember_token
  
  validates :name, :presence => true, :length => { :maximum => 50 } #to validate presence of the name attribute
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  
  private
    
    def create_remember_token
      # Create the token
      # We use self.remember_token to write it to the database along with the other attributes 
      # when the user is saved else it would be a local variable
      self.remember_token = SecureRandom.urlsafe_base64 
    end
    
end
