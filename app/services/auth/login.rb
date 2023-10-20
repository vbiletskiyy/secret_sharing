module Auth
  class Login
    def call(params)
      @params = params
      @user = User.find_by(email: @params[:email])

      authenticate_user
    end

    private

    def authenticate_user
      return unless @user

      @user.authenticate(@params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      { token: token, time: time }
    end
  end
end
