require Rails.root.join("lib/phase0/uat_deploy_hook")

namespace :phase0 do
  namespace :uat do
    desc "Create/update synthetic Pending, Active, and Suspended accounts for Milestone 2 Staging UAT"
    task prepare_accounts: :environment do
      Phase0::UatDeployHook.prepare_accounts!
    end

    desc "Transition the configured Active UAT account to Suspended without ending its existing session"
    task suspend_active: :environment do
      Phase0::UatDeployHook.suspend_active!
    end
  end
end
