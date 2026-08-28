module Members
  class DashboardController < ApplicationController
    before_action :require_active_member!

    def show
    end
  end
end
