class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true, length: {maximum: Settings.name.length.max}
  validates :email, presence: true,
            length: {maximum: Settings.email.length.max},
            format: {with: Settings.email.valid_regex},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true,
            length: {minimum: Settings.password.length.min}

  has_secure_password

  private
  def downcase_email
    self.mail.downcase!
  end
end
