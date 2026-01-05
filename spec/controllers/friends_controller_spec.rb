require "rails_helper"

RSpec.describe FriendsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let!(:friend) { FactoryBot.create(:friend, user: user) }

  before { sign_in user }

  describe "GET #index" do
    it "returns success" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    it "creates a friend" do
      expect {
        post :create, params: {
          friend: {
            first_name: "John",
            last_name: "Doe",
            email: "john@example.com"
          }
        }
      }.to change(user.friends, :count).by(1)
    end
  end

  describe "DELETE #destroy" do
    it "deletes a friend" do
      expect {
        delete :destroy, params: { id: friend.id }
      }.to change(user.friends, :count).by(-1)
      expect(response).to redirect_to(friends_path)
    end
  end
end
