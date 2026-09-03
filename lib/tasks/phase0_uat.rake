namespace :phase0 do
  namespace :uat do
    desc "Create/update synthetic Pending, Active, and Suspended accounts for Milestone 2 Staging UAT"
    task prepare_accounts: :environment do
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
        puts "Prepared #{state}: #{user.email}"
      end
    end

    desc "Transition the configured Active UAT account to Suspended without ending its existing session"
    task suspend_active: :environment do
      email = ENV.fetch("UAT_ACTIVE_EMAIL").to_s.strip.downcase
      user = User.find_by!(email: email)
      user.update!(account_state: :suspended)
      puts "Suspended: #{user.email}"
    end
  end
end
