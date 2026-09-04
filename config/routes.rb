Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resource :registration, only: %i[new create edit update]
  resource :session, only: %i[new create destroy]

  get "/password/reset", to: "password_resets#new", as: :new_password_reset
  post "/password/reset", to: "password_resets#create", as: :password_reset_requests
  get "/password/reset/:token", to: "password_resets#edit", as: :edit_password_reset
  patch "/password/reset/:token", to: "password_resets#update", as: :password_reset

  namespace :members do
    resource :dashboard, only: :show
  end

  namespace :phase0 do
    namespace :uat do
      resource :state_transition, only: %i[show update]
    end
  end

  root "home#index"
end
