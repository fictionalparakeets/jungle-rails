class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, :uniqueness => { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true


  def self.authenticate_with_credentials(email_input, password_input)
    user = User.find_by_email(email_input.strip.downcase)
    if user && user.authenticate(password_input)
      user
    else
      false
    end
  end
  
end
