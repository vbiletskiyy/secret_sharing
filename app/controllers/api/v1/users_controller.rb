class Api::V1::UsersController < ApplicationController
  before_action :authorize_request, except: :create

  def create
    result = Users::Create.new.call(user_params)

    if result.errors.present?
      render json: result.errors.to_h, status: :created
    else
      render json: result, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end
end
