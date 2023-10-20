module AuthenticationHelper
  def authenticate_token(user = nil)
    user ||= create(:user)
    token = JsonWebToken.encode(user_id: user.id)
    { 'Authorization' => token }
  end
end
