class User < ApplicationRecord
  MINIMUM_PASSWORD_LENGTH = 12

  has_secure_password

  generates_token_for :password_reset, expires_in: 30.minutes do
    password_salt&.last(10)
  end

  enum :account_state, {
    pending: "pending",
    active: "active",
    suspended: "suspended"
  }, default: :pending, validate: true

  before_validation :normalize_email

  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
    length: { minimum: MINIMUM_PASSWORD_LENGTH },
    allow_nil: true

  def registration_complete?
    registration_completed_at.present?
  end

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end
