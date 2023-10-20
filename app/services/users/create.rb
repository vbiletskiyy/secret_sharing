module Users
  class Create
    def call(params)
      @params = params
      validation = Users::CreateContract.new.call(params.to_h)
      return validation if validation.errors.present?

      create
    end

    private

    def create
      @user = User.create(@params)
    end
  end
end
