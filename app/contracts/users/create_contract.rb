module Users
  class CreateContract < Dry::Validation::Contract
    params do
      required(:email).filled(:string)
      required(:password).filled(min_size?: 8)
    end

    rule(:email) do
      key.failure('has invalid format') unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure('is already taken') if User.where(email: values[:email]).exists?
    end
  end
end
