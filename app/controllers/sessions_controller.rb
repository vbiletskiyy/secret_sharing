class SessionsController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    result = Auth::Login.new.call(login_params)

    if result
      render json: result, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
