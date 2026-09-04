module Members
  class DashboardsController < ApplicationController
    before_action :require_active_member!

    def show
    end
  end
end
