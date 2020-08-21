class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  def check_permission(user)
    return if user == current_v1_user
    render json: { status: 'ERROR', message: 'Access denied' }, status: 403
  end
end
