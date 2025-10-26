require 'jwt'
require 'net/http'

module Auth0Authenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request
  end

  private

  def authenticate_request
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last if auth_header

    if token
      begin
        decoded_token = decode_jwt(token)
        @current_user = decoded_token
      rescue JWT::DecodeError
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    else
      render json: { error: 'Missing token' }, status: :unauthorized
    end
  end

  def decode_jwt(token)
    jwks_uri = URI("#{ENV['AUTH0_ISSUER_BASE_URL']}.well-known/jwks.json")
    jwks_raw = Net::HTTP.get(jwks_uri)
    jwks_keys = Array(JSON.parse(jwks_raw)['keys'])
    decoded_token = JWT.decode(token, nil, true,
      algorithms: ['RS256'],
      jwks: { keys: jwks_keys }
    )
    decoded_token.first
  end
end