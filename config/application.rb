require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    config.load_defaults 8.0

    # APIモード有効化
    config.api_only = true

    # devise_token_auth がセッションやCookieを使えるようにする
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore
  end
end