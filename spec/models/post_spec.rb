# Test suite for Post model
# Tests validations and associations for user posts.
require "rails_helper"

RSpec.describe Post, type: :model do
  # Test Post model validations
  describe "validations" do
    # A valid post requires content and user association
    it "is valid with valid attributes" do
      user = FactoryBot.create(:user)
      post = Post.new(
        content: "This is a post body",
        user: user
      )
      expect(post).to be_valid
    end

    # Content is a required field
    it "is invalid without content" do
      user = FactoryBot.create(:user)
      post = Post.new(
        content: nil,
        user: user
      )
      expect(post).not_to be_valid
    end

    # User association is required (each post belongs to a user)
    it "is invalid without a user" do
      post = Post.new(
        content: "This is a post body"
      )
      expect(post).not_to be_valid
    end
  end

  # Test Post model associations
  describe "associations" do
    # A post belongs to a user (the post author)
    it "belongs to a user" do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)
      expect(post.user).to eq(user)
    end

    # A post can have many comments (with dependent destroy on deletion)
    it "has many comments" do
      post = FactoryBot.create(:post)
      comment1 = FactoryBot.create(:comment, post: post)
      comment2 = FactoryBot.create(:comment, post: post)
      expect(post.comments.count).to eq(2)
    end
  end
end
