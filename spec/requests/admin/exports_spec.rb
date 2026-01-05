require "rails_helper"

RSpec.describe "Admin Exports", type: :request do
  include Devise::Test::IntegrationHelpers
  
  let(:admin_user) { FactoryBot.create(:user, role: "admin") }
  let(:regular_user) { FactoryBot.create(:user) }

  describe "GET /admin/exports" do
    context "when user is admin" do
      before { sign_in admin_user }

      it "returns http success" do
        get "/admin/exports"
        expect(response).to have_http_status(:ok)
      end
    end

    context "when user is not admin" do
      before { sign_in regular_user }

      it "redirects to root path" do
        get "/admin/exports"
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user is not logged in" do
      it "redirects to login" do
        get "/admin/exports"
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "GET /admin/exports/friends" do
    before { sign_in admin_user }

    it "enqueues ExportFriendsJob" do
      allow(ExportFriendsJob).to receive(:perform_later).and_call_original
      get "/admin/exports/friends"
      expect(ExportFriendsJob).to have_received(:perform_later)
    end

    it "redirects to admin exports path" do
      get "/admin/exports/friends"
      expect(response).to redirect_to(admin_exports_path)
    end

    it "prevents non-admin access" do
      sign_in regular_user
      get "/admin/exports/friends"
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET /admin/exports/posts" do
    before { sign_in admin_user }

    it "enqueues ExportPostsJob" do
      allow(ExportPostsJob).to receive(:perform_later).and_call_original
      get "/admin/exports/posts"
      expect(ExportPostsJob).to have_received(:perform_later)
    end

    it "redirects to admin exports path" do
      get "/admin/exports/posts"
      expect(response).to redirect_to(admin_exports_path)
    end

    it "prevents non-admin access" do
      sign_in regular_user
      get "/admin/exports/posts"
      expect(response).to redirect_to(root_path)
    end
  end
end
