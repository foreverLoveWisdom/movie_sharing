# frozen_string_literal: true

# Shared logic for all controllers
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
end
