class User < ActiveRecord::Base
  has_many :photos, dependent: :destroy

  has_secure_password
  before_save { email.downcase! }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password_confirmation, presence: true
  validates :password, length: { minimum: 6 }

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
