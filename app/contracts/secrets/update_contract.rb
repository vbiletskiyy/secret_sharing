module Secrets
  class UpdateContract < Dry::Validation::Contract
    params do
      optional(:content).filled
      optional(:password).filled(min_size?: 8)
      optional(:expires_at).value(:date)
    end

    rule(:expires_at) do
      key.failure('must be in the future') if value && value <= Date.today
    end
  end
end
