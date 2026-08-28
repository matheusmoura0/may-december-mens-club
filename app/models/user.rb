class User < ApplicationRecord
  has_secure_password

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

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end
