class Api::V1::UsersController < ApplicationController
  include Auth0Authenticatable

  def index
    render json: { message: "こんにちは、#{@current_user['email']} さん！" }
  end
end