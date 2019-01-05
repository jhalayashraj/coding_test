class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ## Associations ##
  has_many :authentication_tokens, dependent: :destroy, inverse_of: :user
  has_many :lists, dependent: :destroy

  ## Validations ##
  validates :username, uniqueness: { case_sensitive: false }

  enum role: { member: 0, admin: 1 }

  ## Class Methods ##
  def self.invalid_credentials
    'Username or Password is not valid'
  end
  
  def self.authenticate_user_with_auth(email, password)
  	return nil unless email.present? || password.present?
  	u = User.find_by(email: email)
    (u.present? && u.valid_password?(password)) ? u : nil
  end
end
