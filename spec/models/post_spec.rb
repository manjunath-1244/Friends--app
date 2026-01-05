require "rails_helper"

RSpec.describe Post, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      user = FactoryBot.create(:user)
      post = Post.new(
        content: "This is a post body",
        user: user
      )
      expect(post).to be_valid
    end

    it "is invalid without content" do
      user = FactoryBot.create(:user)
      post = Post.new(
        content: nil,
        user: user
      )
      expect(post).not_to be_valid
    end

    it "is invalid without a user" do
      post = Post.new(
        content: "This is a post body"
      )
      expect(post).not_to be_valid
    end
  end

  describe "associations" do
    it "belongs to a user" do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)
      expect(post.user).to eq(user)
    end

    it "has many comments" do
      post = FactoryBot.create(:post)
      comment1 = FactoryBot.create(:comment, post: post)
      comment2 = FactoryBot.create(:comment, post: post)
      expect(post.comments.count).to eq(2)
    end
  end
end
