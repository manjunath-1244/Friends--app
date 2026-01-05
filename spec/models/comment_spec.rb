require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)

      comment = Comment.new(
        content: "Nice post",
        user: user,
        post: post
      )
      expect(comment).to be_valid
    end

    it "is invalid without content" do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)

      comment = Comment.new(
        content: nil,
        user: user,
        post: post
      )
      expect(comment).not_to be_valid
    end

    it "is invalid without a user" do
      post = FactoryBot.create(:post)
      comment = Comment.new(
        content: "Nice post",
        post: post
      )
      expect(comment).not_to be_valid
    end

    it "is invalid without a post" do
      user = FactoryBot.create(:user)
      comment = Comment.new(
        content: "Nice post",
        user: user
      )
      expect(comment).not_to be_valid
    end
  end

  describe "associations" do
    it "belongs to a user" do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)
      comment = FactoryBot.create(:comment, user: user, post: post)
      expect(comment.user).to eq(user)
    end

    it "belongs to a post" do
      post = FactoryBot.create(:post)
      comment = FactoryBot.create(:comment, post: post)
      expect(comment.post).to eq(post)
    end
  end
end
