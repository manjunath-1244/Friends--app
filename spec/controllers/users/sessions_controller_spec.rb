require "rails_helper"

RSpec.describe Users::SessionsController, type: :controller do
  let(:user) { FactoryBot.create(:user, password: "password123") }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "POST #create" do
    it "logs in user with valid credentials" do
      post :create, params: {
        user: {
          email: user.email,
          password: "password123"
        }
      }

      expect(response).to have_http_status(:see_other) # ✅ 303
    end
  end
end
