Rails.application.routes.draw do
  # DeviseTokenAuth を JSON API 用にマウント
  mount_devise_token_auth_for 'User', at: 'auth', defaults: { format: :json }

  # ヘルスチェック用
  get "up" => "rails/health#show", as: :rails_health_check

  # root "posts#index"
end