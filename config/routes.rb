Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resource :registration, only: %i[new create]
  resource :session, only: %i[new create destroy]

  namespace :members do
    resource :dashboard, only: :show
  end

  root "home#index"
end
