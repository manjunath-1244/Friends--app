require "rails_helper"

RSpec.describe "Friends", type: :request do
  include Devise::Test::IntegrationHelpers
  
  let(:user) { FactoryBot.create(:user) }
  let(:friend) { FactoryBot.create(:friend, user: user) }

  describe "GET /friends" do
    before { sign_in user }

    it "returns http success" do
      get "/friends"
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /friends/:id" do
    before { sign_in user }

    it "returns http success" do
      get "/friends/#{friend.id}"
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /friends" do
    before { sign_in user }

    it "creates a new friend" do
      expect {
        post "/friends", params: {
          friend: {
            first_name: "Test",
            last_name: "User",
            email: "test@example.com"
          }
        }
      }.to change(Friend, :count).by(1)
    end
  end

  describe "PATCH /friends/:id" do
    before { sign_in user }

    it "updates the friend" do
      patch "/friends/#{friend.id}", params: {
        friend: { first_name: "Updated" }
      }
      expect(friend.reload.first_name).to eq("Updated")
    end
  end

  describe "DELETE /friends/:id" do
    before { sign_in user }

    it "deletes the friend" do
      friend_to_delete = FactoryBot.create(:friend, user: user)
      expect {
        delete "/friends/#{friend_to_delete.id}"
      }.to change(Friend, :count).by(-1)
    end

    it "prevents deleting someone else's friend" do
      other_user = FactoryBot.create(:user)
      other_friend = FactoryBot.create(:friend, user: other_user)
      expect {
        delete "/friends/#{other_friend.id}"
      }.not_to change(Friend, :count)
    end
  end
end
