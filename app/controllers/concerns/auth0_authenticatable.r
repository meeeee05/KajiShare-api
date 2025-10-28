# app/controllers/concerns/auth0_authenticatable.rb
module Auth0Authenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_auth0_user!
  end

  private

  def authenticate_auth0_user!
    token = request.headers['Authorization']&.split(' ')&.last
    unless token
      render json: { error: 'Unauthorized' }, status: :unauthorized
      return
    end

    begin
      @current_user_payload = JWT.decode(
        token,
        Rails.application.credentials.auth0[:client_secret],
        true,
        { algorithm: 'HS256' }
      )[0]
    rescue JWT::DecodeError => e
      render json: { error: e.message }, status: :unauthorized
    end
  end
end