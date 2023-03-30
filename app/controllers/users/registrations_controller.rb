# frozen_string_literal: true

module Users
  # Handle registrations routing
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email])
    end
  end
end
