# Integration tests for Admin Exports endpoints
# Tests access control and background job triggering for data exports.
require "rails_helper"

RSpec.describe "Admin Exports", type: :request do
  # Include Devise integration test helpers for sign_in
  include Devise::Test::IntegrationHelpers
  
  # Create an admin user
  let(:admin_user) { FactoryBot.create(:user, role: "admin") }
  # Create a regular user for testing access control
  let(:regular_user) { FactoryBot.create(:user) }

  # Test access to the exports listing page
  describe "GET /admin/exports" do
    # Test that admin users can access the exports page
    context "when user is admin" do
      before { sign_in admin_user }

      # Verify that authenticated admin users can view the exports page
      it "returns http success" do
        get "/admin/exports"
        expect(response).to have_http_status(:ok)
      end
    end

    # Test that regular users are denied access
    context "when user is not admin" do
      before { sign_in regular_user }

      # Verify that non-admin users are redirected to root path
      it "redirects to root path" do
        get "/admin/exports"
        expect(response).to redirect_to(root_path)
      end
    end

    # Test that unauthenticated users are redirected to login
    context "when user is not logged in" do
      # Verify that unauthenticated users are redirected
      it "redirects to login" do
        get "/admin/exports"
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  # Test exporting friends data
  describe "GET /admin/exports/friends" do
    before { sign_in admin_user }

    # Verify that requesting a friends export enqueues the background job
    it "enqueues ExportFriendsJob" do
      allow(ExportFriendsJob).to receive(:perform_later).and_call_original
      get "/admin/exports/friends"
      expect(ExportFriendsJob).to have_received(:perform_later)
    end

    # Verify that after triggering the export, user is redirected
    it "redirects to admin exports path" do
      get "/admin/exports/friends"
      expect(response).to redirect_to(admin_exports_path)
    end

    # Verify that non-admin users cannot trigger exports
    it "prevents non-admin access" do
      sign_in regular_user
      get "/admin/exports/friends"
      expect(response).to redirect_to(root_path)
    end
  end

  # Test exporting posts data
  describe "GET /admin/exports/posts" do
    before { sign_in admin_user }

    # Verify that requesting a posts export enqueues the background job
    it "enqueues ExportPostsJob" do
      allow(ExportPostsJob).to receive(:perform_later).and_call_original
      get "/admin/exports/posts"
      expect(ExportPostsJob).to have_received(:perform_later)
    end

    # Verify that after triggering the export, user is redirected
    it "redirects to admin exports path" do
      get "/admin/exports/posts"
      expect(response).to redirect_to(admin_exports_path)
    end

    # Verify that non-admin users cannot trigger exports
    it "prevents non-admin access" do
      sign_in regular_user
      get "/admin/exports/posts"
      expect(response).to redirect_to(root_path)
    end
  end
end
