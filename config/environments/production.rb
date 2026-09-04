Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.force_ssl = ENV.fetch("FORCE_SSL", "true") == "true"
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.log_tags = [ :request_id ]
  config.active_support.report_deprecations = false

  # Render captures process stdout/stderr. Keep Rails runtime exceptions and
  # mail delivery failures visible there so Staging UAT failures are diagnosable.
  config.logger = ActiveSupport::TaggedLogging.logger($stdout)

  # Phase 0 does not authorize live Production provider credentials. External
  # delivery is opt-in so the business-controlled non-Production Staging service
  # can exercise password recovery without enabling a Production launch.
  smtp_configured = %w[SMTP_ADDRESS SMTP_USERNAME SMTP_PASSWORD].all? { |key| ENV[key].present? }
  mail_delivery_enabled = ENV.fetch("MAIL_DELIVERY_ENABLED", smtp_configured ? "true" : "false") == "true"
  config.action_mailer.perform_deliveries = mail_delivery_enabled
  config.action_mailer.raise_delivery_errors = true

  if mail_delivery_enabled
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: ENV.fetch("SMTP_ADDRESS"),
      port: ENV.fetch("SMTP_PORT", "587").to_i,
      domain: ENV.fetch("SMTP_DOMAIN", "mail.maydecemberclub.com"),
      user_name: ENV.fetch("SMTP_USERNAME"),
      password: ENV.fetch("SMTP_PASSWORD"),
      authentication: ENV.fetch("SMTP_AUTHENTICATION", "plain").to_sym,
      enable_starttls_auto: ENV.fetch("SMTP_STARTTLS", "true") == "true"
    }
  end
end
