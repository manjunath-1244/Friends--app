require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:post_record) { FactoryBot.create(:post, user: user, content: "Post content") }

  before { sign_in user }

  describe "POST #create" do
    it "creates a comment for the post" do
      expect {
        post :create, params: {
          post_id: post_record.id,
          comment: { content: "Nice post!" }
        }
      }.to change(post_record.comments, :count).by(1)
    end
  end

  describe "DELETE #destroy" do
    let!(:comment) { FactoryBot.create(:comment, post: post_record, user: user) }

    it "allows comment owner to delete" do
      delete :destroy, params: { post_id: post_record.id, id: comment.id }
      expect(response).to redirect_to(post_record)
    end
  end
end
