# frozen_string_literal: true

# View helpers for the whole application
module ApplicationHelper
  def username(user)
    "Welcome #{user.email}"
  end
end
