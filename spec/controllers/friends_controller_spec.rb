# Test suite for FriendsController
# Tests CRUD operations for managing a user's friends list.
require "rails_helper"

RSpec.describe FriendsController, type: :controller do
  # Create a test user who owns friends
  let(:user) { FactoryBot.create(:user) }
  # Create a friend record owned by the test user
  let!(:friend) { FactoryBot.create(:friend, user: user) }

  # Sign in as the test user before each test
  before { sign_in user }

  # Test the index action (list all friends)
  describe "GET #index" do
    # Verify that accessing the friends list returns a successful response
    it "returns success" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  # Test the create action (add a new friend)
  describe "POST #create" do
    # Verify that creating a friend with valid data increments the user's friend count
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

  # Test the destroy action (remove a friend)
  describe "DELETE #destroy" do
    # Verify that deleting a friend decrements the user's friend count
    it "deletes a friend" do
      expect {
        delete :destroy, params: { id: friend.id }
      }.to change(user.friends, :count).by(-1)
      # Should redirect back to the friends list after successful deletion
      expect(response).to redirect_to(friends_path)
    end
  end
end
