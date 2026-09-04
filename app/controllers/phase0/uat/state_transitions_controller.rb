module Phase0
  module Uat
    class StateTransitionsController < ApplicationController
      before_action :require_authentication!
      before_action :require_staging_uat_user!

      def show
      end

      def update
        current_user.update!(account_state: :suspended)
        redirect_to phase0_uat_state_transition_path, notice: "UAT account state changed to suspended. Keep this same browser session and request /members/dashboard again."
      end

      private

      def require_staging_uat_user!
        unless ENV["APP_BASE_URL"] == "https://may-december-staging.onrender.com"
          head :not_found
          return
        end

        uat_email = ENV["UAT_ACTIVE_EMAIL"].to_s.strip.downcase
        unless uat_email.present? && current_user.email.to_s.strip.downcase == uat_email
          head :not_found
        end
      end
    end
  end
end
