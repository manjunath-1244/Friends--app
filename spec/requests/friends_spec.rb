# Integration tests for Friends resource endpoints
# Tests HTTP requests to friends CRUD actions using full request/response cycle.
require "rails_helper"

RSpec.describe "Friends", type: :request do
  # Include Devise integration test helpers for sign_in
  include Devise::Test::IntegrationHelpers
  
  # Create a test user to own friends
  let(:user) { FactoryBot.create(:user) }
  # Create a friend owned by the test user
  let(:friend) { FactoryBot.create(:friend, user: user) }

  # Test listing all friends
  describe "GET /friends" do
    # Sign in before each test in this describe block
    before { sign_in user }

    # Verify that accessing the friends index returns success
    it "returns http success" do
      get "/friends"
      expect(response).to have_http_status(:ok)
    end
  end

  # Test viewing a single friend
  describe "GET /friends/:id" do
    before { sign_in user }

    # Verify that accessing a specific friend's detail page returns success
    it "returns http success" do
      get "/friends/#{friend.id}"
      expect(response).to have_http_status(:ok)
    end
  end

  # Test creating a new friend
  describe "POST /friends" do
    before { sign_in user }

    # Verify that creating a friend with valid data increases the Friend count
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

  # Test updating an existing friend
  describe "PATCH /friends/:id" do
    before { sign_in user }

    # Verify that updating a friend record persists the changes
    it "updates the friend" do
      patch "/friends/#{friend.id}", params: {
        friend: { first_name: "Updated" }
      }
      expect(friend.reload.first_name).to eq("Updated")
    end
  end

  # Test deleting a friend
  describe "DELETE /friends/:id" do
    before { sign_in user }

    # Verify that deleting an owned friend decreases the Friend count
    it "deletes the friend" do
      friend_to_delete = FactoryBot.create(:friend, user: user)
      expect {
        delete "/friends/#{friend_to_delete.id}"
      }.to change(Friend, :count).by(-1)
    end

    # Verify that users cannot delete friends owned by other users
    it "prevents deleting someone else's friend" do
      other_user = FactoryBot.create(:user)
      other_friend = FactoryBot.create(:friend, user: other_user)
      expect {
        delete "/friends/#{other_friend.id}"
      }.not_to change(Friend, :count)
    end
  end
end
