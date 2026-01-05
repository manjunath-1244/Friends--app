require "rails_helper"

RSpec.describe PostsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  before { sign_in user }

  describe "GET #index" do
    it "returns success" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    it "creates a post with content" do
      expect {
        post :create, params: {
          post: { content: "This is a post" }
        }
      }.to change(Post, :count).by(1)
    end
  end

  describe "DELETE #destroy" do
    let!(:post_record) { FactoryBot.create(:post, user: user, content: "Delete me") }

    it "allows owner to delete post" do
      delete :destroy, params: { id: post_record.id }
      expect(response).to redirect_to(posts_path)
    end
  end
end
