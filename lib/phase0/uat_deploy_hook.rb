module Phase0
  module UatDeployHook
    STAGING_BASE_URL = "https://may-december-staging.onrender.com"

    module_function

    def run!
      return unless staging_service?

      prepare_accounts! if enabled?("PREPARE_UAT_ACCOUNTS")
      suspend_active! if enabled?("UAT_SUSPEND_ACTIVE")
    end

    def prepare_accounts!
      password = ENV.fetch("UAT_PASSWORD")
      accounts = {
        pending: ENV.fetch("UAT_PENDING_EMAIL"),
        active: ENV.fetch("UAT_ACTIVE_EMAIL"),
        suspended: ENV.fetch("UAT_SUSPENDED_EMAIL")
      }

      accounts.each do |state, raw_email|
        email = raw_email.to_s.strip.downcase
        user = User.find_or_initialize_by(email: email)
        user.assign_attributes(
          password: password,
          password_confirmation: password,
          account_state: state,
          registration_completed_at: Time.current
        )
        user.save!
        $stdout.puts("[phase0-uat] Prepared #{state} account: #{user.email}")
      end
    end

    def suspend_active!
      email = ENV.fetch("UAT_ACTIVE_EMAIL").to_s.strip.downcase
      user = User.find_by!(email: email)
      user.update!(account_state: :suspended)
      $stdout.puts("[phase0-uat] Suspended active UAT account: #{user.email}")
    end

    def staging_service?
      ENV["APP_BASE_URL"].to_s.delete_suffix("/") == STAGING_BASE_URL
    end

    def enabled?(key)
      ENV.fetch(key, "false").casecmp?("true")
    end
  end
end
