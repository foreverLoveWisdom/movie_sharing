# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    # before_action :configure_permitted_parameters

    # protected

    # def configure_permitted_parameters
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
    # end

    # def sign_in_params
    #   params.require(:user).permit(:username, :password)
    # end

    # def sign_in(resource_or_scope, resource = nil)
    #   super
    #   return unless resource.is_a?(User)

    #   resource.update_column(:last_sign_in_at, Time.current)
    # end
  end
end
