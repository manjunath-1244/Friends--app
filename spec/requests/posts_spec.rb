require "rails_helper"

RSpec.describe "Posts", type: :request do
  include Devise::Test::IntegrationHelpers
  
  let(:user) { FactoryBot.create(:user) }
  let(:admin_user) { FactoryBot.create(:user, role: "admin") }
  let(:post_obj) { FactoryBot.create(:post, user: user) }

  describe "GET /posts" do
    before { sign_in user }

    it "returns http success" do
      get "/posts"
      expect(response).to have_http_status(:ok)
    end

    it "assigns all posts" do
      FactoryBot.create(:post)
      get "/posts"
      expect(response.body).to include("Post")
    end
  end

  describe "GET /posts/:id" do
    before { sign_in user }

    it "returns http success" do
      get "/posts/#{post_obj.id}"
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /posts/new" do
    before { sign_in user }

    it "returns http success" do
      get "/posts/new"
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /posts" do
    before { sign_in user }

    it "creates a new post" do
      expect {
        post "/posts", params: {
          post: { content: "My new post" }
        }
      }.to change(Post, :count).by(1)
    end

    it "redirects to the created post" do
      post "/posts", params: {
        post: { content: "My new post" }
      }
      expect(response).to redirect_to(Post.last)
    end

    it "fails when content is empty" do
      post "/posts", params: {
        post: { content: "" }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /posts/:id" do
    before { sign_in user }

    it "deletes the post if owner" do
      post_to_delete = FactoryBot.create(:post, user: user)
      expect {
        delete "/posts/#{post_to_delete.id}"
      }.to change(Post, :count).by(-1)
    end

    it "prevents non-owner from deleting" do
      other_user = FactoryBot.create(:user)
      sign_in other_user
      delete "/posts/#{post_obj.id}"
      expect(response).to redirect_to(posts_path)
      expect(Post.find_by(id: post_obj.id)).not_to be_nil
    end
  end
end
