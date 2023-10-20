class ApplicationController < ActionController::API
  private

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      decoded = JsonWebToken.decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def render_json(result)
    if result.errors.present?
      render json: { success: false,
                     errors: result.errors.to_h }, status: :unprocessable_entity
    else
      render json: { success: true, secret: result }
    end
  end

  def resource_found?(resource)
    return if resource

    render json: { success: false, message: 'The requested record does not exist.' }, status: :not_found
  end
end
