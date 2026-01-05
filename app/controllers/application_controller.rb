class ApplicationController < ActionController::Base
  # Main application controller for browser-based UI requests.
  # - Enables CSRF protection for HTML forms (`protect_from_forgery with: :exception`).
  # - Uses Devise `authenticate_user!` for UI access control; API controllers
  #   live under `Api::V1` and use `ActionController::API` + JWT instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  # After successful sign in for UI users, redirect to the friends index.
  def after_sign_in_path_for(resource)
    friends_path
  end

  # After sign out (UI), redirect to Devise's login page.
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end

