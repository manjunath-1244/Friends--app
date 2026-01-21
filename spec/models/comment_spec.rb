# Test suite for Comment model
# Tests validations and associations for post comments.
require "rails_helper"

RSpec.describe Comment, type: :model do
  # Test Comment model validations
  describe "validations" do
    # A valid comment requires content, user, and post association
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

    # Comment content is a required field
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

    # User association is required (each comment belongs to a comment author)
    it "is invalid without a user" do
      post = FactoryBot.create(:post)
      comment = Comment.new(
        content: "Nice post",
        post: post
      )
      expect(comment).not_to be_valid
    end

    # Post association is required (each comment belongs to a post)
    it "is invalid without a post" do
      user = FactoryBot.create(:user)
      comment = Comment.new(
        content: "Nice post",
        user: user
      )
      expect(comment).not_to be_valid
    end
  end

  # Test Comment model associations
  describe "associations" do
    # A comment belongs to a user (the comment author)
    it "belongs to a user" do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)
      comment = FactoryBot.create(:comment, user: user, post: post)
      expect(comment.user).to eq(user)
    end

    # A comment belongs to a post
    it "belongs to a post" do
      post = FactoryBot.create(:post)
      comment = FactoryBot.create(:comment, post: post)
      expect(comment.post).to eq(post)
    end
  end
end
