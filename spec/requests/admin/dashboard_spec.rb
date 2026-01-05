require "rails_helper"

RSpec.describe "Admin Dashboard", type: :request do
  include Devise::Test::IntegrationHelpers
  
  let(:admin_user) { FactoryBot.create(:user, role: "admin") }
  let(:regular_user) { FactoryBot.create(:user) }

  describe "GET /admin/dashboard" do
    context "when user is admin" do
      before { sign_in admin_user }

      it "returns http success" do
        get "/admin/dashboard"
        expect(response).to have_http_status(:ok)
      end
    end

    context "when user is not admin" do
      before { sign_in regular_user }

      it "redirects to root path" do
        get "/admin/dashboard"
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user is not logged in" do
      it "redirects to login" do
        get "/admin/dashboard"
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
