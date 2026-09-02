Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.force_ssl = ENV.fetch("FORCE_SSL", "true") == "true"
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.log_tags = [ :request_id ]
  config.active_support.report_deprecations = false

  # Phase 0 does not authorize live Production provider credentials. Password
  # recovery is implemented end-to-end, while external delivery remains opt-in.
  config.action_mailer.perform_deliveries = ENV.fetch("MAIL_DELIVERY_ENABLED", "false") == "true"
end
