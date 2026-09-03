require_relative "config/environment"
require Rails.root.join("lib/phase0/uat_deploy_hook")

Phase0::UatDeployHook.run!

run Rails.application
Rails.application.load_server
