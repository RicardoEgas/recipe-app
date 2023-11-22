# class ApplicationController < ActionController::Base
#     # protect_from_forgery with: :null_session

#     # before_action :authenticate_user!
#     before_action :configure_permitted_parameters, if: :devise_controller?

#     protected

#     # def configure_permitted_parameters
#     #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
#     #   devise_parameter_sanitizer.permit(:account_update, keys: [:name])
#     # end
#   def configure_permitted_parameters
#       devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
#   end
# end
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
