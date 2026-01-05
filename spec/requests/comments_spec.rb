require "rails_helper"

RSpec.describe "Comments", type: :request do
  include Devise::Test::IntegrationHelpers
  
  let(:user) { FactoryBot.create(:user) }
  let(:post_obj) { FactoryBot.create(:post, user: user) }
  let(:comment) { FactoryBot.create(:comment, user: user, post: post_obj) }

  describe "POST /posts/:post_id/comments" do
    before { sign_in user }

    it "creates a new comment on a post" do
      expect {
        post "/posts/#{post_obj.id}/comments", params: {
          comment: { content: "Great post!" }
        }
      }.to change(Comment, :count).by(1)
    end

    it "redirects with alert when comment is empty" do
      post "/posts/#{post_obj.id}/comments", params: {
        comment: { content: "" }
      }
      expect(response).to redirect_to(post_obj)
    end
  end

  describe "GET /posts/:post_id/comments/:id/edit" do
    before { sign_in user }

    it "allows comment owner to edit" do
      get "/posts/#{post_obj.id}/comments/#{comment.id}/edit"
      expect(response).to have_http_status(:ok)
    end

    it "prevents non-owner from editing" do
      other_user = FactoryBot.create(:user)
      sign_in other_user
      get "/posts/#{post_obj.id}/comments/#{comment.id}/edit"
      expect(response).to redirect_to(post_obj)
    end
  end

  describe "PATCH /posts/:post_id/comments/:id" do
    before { sign_in user }

    it "updates the comment" do
      patch "/posts/#{post_obj.id}/comments/#{comment.id}", params: {
        comment: { content: "Updated comment" }
      }
      expect(comment.reload.content).to eq("Updated comment")
    end
  end

  describe "DELETE /posts/:post_id/comments/:id" do
    before { sign_in user }

    it "deletes the comment" do
      comment_to_delete = FactoryBot.create(:comment, user: user, post: post_obj)
      expect {
        delete "/posts/#{post_obj.id}/comments/#{comment_to_delete.id}"
      }.to change(Comment, :count).by(-1)
    end
  end
end
