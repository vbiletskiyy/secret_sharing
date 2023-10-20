module Secrets
  class Update
    def call(secret, params)
      @secret = secret
      @params = params
      validation = Secrets::CreateContract.new.call(@params.to_h)
      return validation if validation.errors.present?

      update
    end

    def update
      @secret.update(@params)
      @secret
    end
  end
end
