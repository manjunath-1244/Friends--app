# Integration tests for Comments resource endpoints (nested under Posts)
# Tests HTTP requests to comments CRUD actions using full request/response cycle.
require "rails_helper"

RSpec.describe "Comments", type: :request do
  # Include Devise integration test helpers for sign_in
  include Devise::Test::IntegrationHelpers
  
  # Create a test user to own comments
  let(:user) { FactoryBot.create(:user) }
  # Create a post owned by the test user
  let(:post_obj) { FactoryBot.create(:post, user: user) }
  # Create a comment owned by the test user on the test post
  let(:comment) { FactoryBot.create(:comment, user: user, post: post_obj) }

  # Test creating a comment on a post
  describe "POST /posts/:post_id/comments" do
    before { sign_in user }

    # Verify that creating a comment with valid content increases the Comment count
    it "creates a new comment on a post" do
      expect {
        post "/posts/#{post_obj.id}/comments", params: {
          comment: { content: "Great post!" }
        }
      }.to change(Comment, :count).by(1)
    end

    # Verify that a comment with empty content is rejected
    it "redirects with alert when comment is empty" do
      post "/posts/#{post_obj.id}/comments", params: {
        comment: { content: "" }
      }
      expect(response).to redirect_to(post_obj)
    end
  end

  # Test accessing the edit form for a comment
  describe "GET /posts/:post_id/comments/:id/edit" do
    before { sign_in user }

    # Verify that the comment owner can access the edit form
    it "allows comment owner to edit" do
      get "/posts/#{post_obj.id}/comments/#{comment.id}/edit"
      expect(response).to have_http_status(:ok)
    end

    # Verify that non-owners cannot access the edit form
    it "prevents non-owner from editing" do
      other_user = FactoryBot.create(:user)
      sign_in other_user
      get "/posts/#{post_obj.id}/comments/#{comment.id}/edit"
      # Should redirect and not allow access
      expect(response).to redirect_to(post_obj)
    end
  end

  # Test updating a comment
  describe "PATCH /posts/:post_id/comments/:id" do
    before { sign_in user }

    # Verify that updating a comment persists the changes
    it "updates the comment" do
      patch "/posts/#{post_obj.id}/comments/#{comment.id}", params: {
        comment: { content: "Updated comment" }
      }
      expect(comment.reload.content).to eq("Updated comment")
    end
  end

  # Test deleting a comment
  describe "DELETE /posts/:post_id/comments/:id" do
    before { sign_in user }

    # Verify that deleting a comment decreases the Comment count
    it "deletes the comment" do
      comment_to_delete = FactoryBot.create(:comment, user: user, post: post_obj)
      expect {
        delete "/posts/#{post_obj.id}/comments/#{comment_to_delete.id}"
      }.to change(Comment, :count).by(-1)
    end
  end
end
