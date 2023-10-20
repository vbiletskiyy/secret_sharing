class SecretPolicy
  def initialize(secret, password)
    @secret = secret
    @password = password
  end

  def show?
    password_matches? && not_expired?
  end

  private

  def password_matches?
    @secret.password_digest == @password
  end

  def not_expired?
    @secret.expires_at.nil? || @secret.expires_at > Date.today
  end
end
