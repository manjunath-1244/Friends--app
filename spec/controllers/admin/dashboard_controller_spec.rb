require "rails_helper"

RSpec.describe Admin::DashboardController, type: :controller do
  let(:admin) { FactoryBot.create(:user, role: "admin") }

  before { sign_in admin }

  describe "GET #index" do
    it "allows admin access" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
end
