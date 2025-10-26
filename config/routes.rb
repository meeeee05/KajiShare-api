Rails.application.routes.draw do
  # DeviseTokenAuth を JSON API 用にマウント
  mount_devise_token_auth_for 'User', at: 'auth', defaults: { format: :json }

  get "up" => "rails/health#show", as: :rails_health_check

  # root "posts#index"

  Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'users', to: 'users#index'
    end
  end
end