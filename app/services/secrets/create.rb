module Secrets
  class Create
    def call(params)
      @params = params
      validation = Secrets::CreateContract.new.call(@params.to_h)
      return validation if validation.errors.present?

      create
    end

    private
    
    def url
      SecureRandom.uuid
    end

    def create
      Secret.create(@params.merge(url: url))
    end
  end
end
