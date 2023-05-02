Rails.application.routes.draw do
  post "/auth/login", to: "authentication#authenticate"

  namespace :api do
    namespace :v1 do
      resources :reservations, only: [:index, :show, :create]
      resources :restaurants
    end
  end
end
