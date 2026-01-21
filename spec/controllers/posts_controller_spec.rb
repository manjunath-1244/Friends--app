# Test suite for PostsController
# Tests CRUD operations for creating, reading, updating, and deleting posts.
require "rails_helper"

RSpec.describe PostsController, type: :controller do
  # Create a test user who owns posts
  let(:user) { FactoryBot.create(:user) }

  # Sign in as the test user before each test
  before { sign_in user }

  # Test the index action (list all posts)
  describe "GET #index" do
    # Verify that accessing the posts list returns a successful response
    it "returns success" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  # Test the create action (publish a new post)
  describe "POST #create" do
    # Verify that creating a post with content increments the Post count
    it "creates a post with content" do
      expect {
        post :create, params: {
          post: { content: "This is a post" }
        }
      }.to change(Post, :count).by(1)
    end
  end

  # Test the destroy action (delete a post)
  describe "DELETE #destroy" do
    # Create a test post owned by the user
    let!(:post_record) { FactoryBot.create(:post, user: user, content: "Delete me") }

    # Verify that the post owner can delete their own post
    it "allows owner to delete post" do
      delete :destroy, params: { id: post_record.id }
      # Should redirect back to the posts list after successful deletion
      expect(response).to redirect_to(posts_path)
    end
  end
end
