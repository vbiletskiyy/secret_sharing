class Api::V1::SecretsController < ApplicationController
  before_action :authorize_request
  before_action :set_secret, only: %i[show update destroy]
  before_action :authorize_secret, only: %i[update destroy]

  def index
    secrets = @current_user.secrets

    render json: SecretBlueprint.render(secrets, view: :extended)
  end

  def show
    policy = SecretPolicy.new(@secret, params[:password])
    if policy.show?
      render json: SecretBlueprint.render(@secret)
    else
      render json: { error: 'Invalid password or secret has expired.' }, status: :forbidden
    end
  end

  def create
    result = Secrets::Create.new.call(secret_params)
    render_json(result)
  end

  def update
    result = Secrets::Update.new.call(@secret, secret_params)
    render_json(result)
  end

  def destroy
    @secret.destroy
    render json: { success: true, message: 'Secret has been deleted' }
  end

  private

  def secret_params
    params.require(:secret).permit(:content, :password, :expires_at).merge(user_id: @current_user.id)
  end

  def set_secret
    @secret = Secret.find_by(url: params[:url])
    resource_found?(@secret)
  end

  def authorize_secret
    return if @secret.user == @current_user

    render json: { error: 'You have no right to modify that secret.' }, status: :forbidden
  end
end
