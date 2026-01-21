# Test suite for CommentsController
# Tests the creation, editing, updating, and deletion of comments on posts.
require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  # Create a test user for request context
  let(:user) { FactoryBot.create(:user) }
  # Create a test post owned by the user
  let(:post_record) { FactoryBot.create(:post, user: user, content: "Post content") }

  # Sign in as the test user before each test
  before { sign_in user }

  # Test the create action
  describe "POST #create" do
    # Verify that posting a valid comment increments the post's comment count
    it "creates a comment for the post" do
      expect {
        post :create, params: {
          post_id: post_record.id,
          comment: { content: "Nice post!" }
        }
      }.to change(post_record.comments, :count).by(1)
    end
  end

  # Test the destroy action
  describe "DELETE #destroy" do
    # Create a comment owned by the test user
    let!(:comment) { FactoryBot.create(:comment, post: post_record, user: user) }

    # Verify that the comment owner can delete their own comment
    it "allows comment owner to delete" do
      delete :destroy, params: { post_id: post_record.id, id: comment.id }
      # Should redirect back to the post after successful deletion
      expect(response).to redirect_to(post_record)
    end
  end
end
