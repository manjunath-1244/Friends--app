# Integration tests for Admin Dashboard endpoint
# Tests access control and authorization for admin-only features.
require "rails_helper"

RSpec.describe "Admin Dashboard", type: :request do
  # Include Devise integration test helpers for sign_in
  include Devise::Test::IntegrationHelpers
  
  # Create an admin user
  let(:admin_user) { FactoryBot.create(:user, role: "admin") }
  # Create a regular user for testing access control
  let(:regular_user) { FactoryBot.create(:user) }

  # Test access to the admin dashboard
  describe "GET /admin/dashboard" do
    # Test that admin users can access the dashboard
    context "when user is admin" do
      before { sign_in admin_user }

      # Verify that authenticated admin users can access the dashboard
      it "returns http success" do
        get "/admin/dashboard"
        expect(response).to have_http_status(:ok)
      end
    end

    # Test that regular users are denied access
    context "when user is not admin" do
      before { sign_in regular_user }

      # Verify that non-admin users are redirected
      it "redirects to root path" do
        get "/admin/dashboard"
        expect(response).to redirect_to(root_path)
      end
    end

    # Test that unauthenticated users are redirected to login
    context "when user is not logged in" do
      # Verify that unauthenticated users are redirected
      it "redirects to login" do
        get "/admin/dashboard"
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
