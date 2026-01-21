# Integration tests for Posts resource endpoints
# Tests HTTP requests to posts CRUD actions using full request/response cycle.
require "rails_helper"

RSpec.describe "Posts", type: :request do
  # Include Devise integration test helpers for sign_in
  include Devise::Test::IntegrationHelpers
  
  # Create a test user to own posts
  let(:user) { FactoryBot.create(:user) }
  # Create an admin user for authorization tests
  let(:admin_user) { FactoryBot.create(:user, role: "admin") }
  # Create a post owned by the test user
  let(:post_obj) { FactoryBot.create(:post, user: user) }

  # Test listing all posts
  describe "GET /posts" do
    before { sign_in user }

    # Verify that accessing the posts index returns success
    it "returns http success" do
      get "/posts"
      expect(response).to have_http_status(:ok)
    end

    # Verify that the posts listing loads post content
    it "assigns all posts" do
      FactoryBot.create(:post)
      get "/posts"
      expect(response.body).to include("Post")
    end
  end

  # Test viewing a single post
  describe "GET /posts/:id" do
    before { sign_in user }

    # Verify that accessing a specific post's detail page returns success
    it "returns http success" do
      get "/posts/#{post_obj.id}"
      expect(response).to have_http_status(:ok)
    end
  end

  # Test viewing the new post form
  describe "GET /posts/new" do
    before { sign_in user }

    # Verify that the new post form page is accessible
    it "returns http success" do
      get "/posts/new"
      expect(response).to have_http_status(:ok)
    end
  end

  # Test creating a new post
  describe "POST /posts" do
    before { sign_in user }

    # Verify that creating a post with valid content increases the Post count
    it "creates a new post" do
      expect {
        post "/posts", params: {
          post: { content: "My new post" }
        }
      }.to change(Post, :count).by(1)
    end

    # Verify that after creating a post, the user is redirected to the post
    it "redirects to the created post" do
      post "/posts", params: {
        post: { content: "My new post" }
      }
      expect(response).to redirect_to(Post.last)
    end

    # Verify that a post with empty content is rejected
    it "fails when content is empty" do
      post "/posts", params: {
        post: { content: "" }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  # Test deleting a post
  describe "DELETE /posts/:id" do
    before { sign_in user }

    # Verify that the post owner can delete their own post
    it "deletes the post if owner" do
      post_to_delete = FactoryBot.create(:post, user: user)
      expect {
        delete "/posts/#{post_to_delete.id}"
      }.to change(Post, :count).by(-1)
    end

    # Verify that non-owners cannot delete posts
    it "prevents non-owner from deleting" do
      other_user = FactoryBot.create(:user)
      sign_in other_user
      delete "/posts/#{post_obj.id}"
      expect(response).to redirect_to(posts_path)
      # Verify the post still exists
      expect(Post.find_by(id: post_obj.id)).not_to be_nil
    end
  end
end
