# app/controllers/api/v1/users_controller.rb
class Api::V1::UsersController < ApplicationController
  include Auth0Authenticatable

  def index
    render json: { message: "Hello, Auth0 user!", user: @current_user_payload }
  end
end