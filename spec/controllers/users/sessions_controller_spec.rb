# Test suite for Users::SessionsController
# Tests user authentication and session management (login/logout).
require "rails_helper"

RSpec.describe Users::SessionsController, type: :controller do
  # Create a test user with a known password for authentication tests
  let(:user) { FactoryBot.create(:user, password: "password123") }

  # Configure Devise mapping for the test context
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  # Test the create action (user login)
  describe "POST #create" do
    # Verify that a user can log in with valid email and password credentials
    it "logs in user with valid credentials" do
      post :create, params: {
        user: {
          email: user.email,
          password: "password123"
        }
      }

      # Should return 303 See Other redirect after successful login
      expect(response).to have_http_status(:see_other)
    end
  end
end
