class Users::SessionsController < Devise::SessionsController
  # This controller customizes Devise session handling to support both
  # traditional browser UI flows (HTML) and API clients that expect JSON.
  #
  # Key points:
  # - For JSON requests we skip CSRF verification and return JSON payloads
  #   (useful for Postman/API clients and JWT flows).
  # - For HTML requests we keep Devise's normal behaviour and explicitly
  #   sign out and redirect so the browser receives a fresh login page
  #   and CSRF token.
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  # Devise's `verify_signed_out_user` can return 204 early; skip it so our
  # HTML destroy action always runs and redirects to the login page.
  skip_before_action :verify_signed_out_user, only: :destroy
  respond_to :html, :json

  # Handle JSON sign-in for API clients (Postman). Accepts both
  # top-level `{ email, password }` and nested `{ user: { email, password } }`.
  # Returns user JSON on success, or 401/422 on failure.
  def create
    if request.format.json?
      email = params[:email] || params.dig(:user, :email)
      password = params[:password] || params.dig(:user, :password)
      Rails.logger.info("Users::SessionsController JSON login attempt: email=#{email.inspect}, password_present=#{password.present?}")
      user = User.find_by(email: email.to_s.downcase)
      Rails.logger.info("Users::SessionsController found user=#{user&.id || 'nil'} email=#{user&.email}")

      if user&.valid_password?(password)
        sign_in(user)
        render json: user.as_json(only: %i[id email first_name role created_at updated_at]), status: :ok
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    else
      super
    end
  end

  # Sign out handler supporting both JSON (API) and HTML (UI) flows.
  # - JSON: returns `{ redirect_url: ... }` so API clients can handle redirect.
  # - HTML: explicitly signs out and redirects to the login page so the
  #   browser reloads and receives a fresh CSRF token.
  def destroy
    if request.format.json?
      sign_out(current_user) if current_user
      render json: { redirect_url: new_user_session_path }, status: :ok
    elsif request.format.html?
      sign_out(current_user) if current_user
      redirect_to new_user_session_path
    else
      super
    end
  end
end