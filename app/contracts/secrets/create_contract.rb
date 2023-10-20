module Secrets
  class CreateContract < Dry::Validation::Contract
    params do
      required(:content).filled
      required(:password).filled(min_size?: 8)
      optional(:expires_at).value(:date)
    end

    rule(:expires_at) do
      key.failure('must be in the future') if value && value <= Date.today
    end
  end
end
