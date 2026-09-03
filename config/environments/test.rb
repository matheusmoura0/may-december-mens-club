Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = ENV["CI"].present?
  config.public_file_server.enabled = true
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.action_controller.allow_forgery_protection = false
  config.cache_store = :null_store
  config.action_dispatch.show_exceptions = :rescuable
  config.active_support.deprecation = :stderr

  # Keep password-recovery tests fully local. Phase 0 does not require live mail delivery.
  config.action_mailer.delivery_method = :test
  config.action_mailer.perform_deliveries = true
end
