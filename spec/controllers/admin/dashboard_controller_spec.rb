# Test suite for Admin::DashboardController
# Tests access control and dashboard functionality for admin users.
require "rails_helper"

RSpec.describe Admin::DashboardController, type: :controller do
  # Create a test user with admin role
  let(:admin) { FactoryBot.create(:user, role: "admin") }

  # Sign in as the admin user before each test
  before { sign_in admin }

  # Test the index action (admin dashboard)
  describe "GET #index" do
    # Verify that authenticated admin users can access the dashboard
    it "allows admin access" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
end
