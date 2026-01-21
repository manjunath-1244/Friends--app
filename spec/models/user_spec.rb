# Test suite for User model
# Tests validations, associations, and helper methods.
require "rails_helper"

RSpec.describe User, type: :model do
  # Test that the FactoryBot user factory generates valid users
  describe "factory" do
    it "has a valid factory" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
  end

  # Test User model validations
  describe "validations" do
    # Email is required and must be in valid format
    it "is invalid without an email" do
      user = FactoryBot.build(:user, email: nil)
      expect(user).not_to be_valid
    end

    # Email must follow valid email format
    it "is invalid with an invalid email format" do
      user = FactoryBot.build(:user, email: "not-an-email")
      expect(user).not_to be_valid
    end

    # Password is required (Devise validation)
    it "is invalid without a password" do
      user = FactoryBot.build(:user, password: nil)
      expect(user).not_to be_valid
    end
  end

  # Test User model associations
  describe "associations" do
    # A user can have many friends
    it "has many friends" do
      user = FactoryBot.create(:user)
      friend1 = FactoryBot.create(:friend, user: user)
      friend2 = FactoryBot.create(:friend, user: user)
      expect(user.friends.count).to eq(2)
    end

    # A user can write many posts
    it "has many posts" do
      user = FactoryBot.create(:user)
      post1 = FactoryBot.create(:post, user: user)
      post2 = FactoryBot.create(:post, user: user)
      expect(user.posts.count).to eq(2)
    end

    # A user can write many comments
    it "has many comments" do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)
      comment1 = FactoryBot.create(:comment, user: user, post: post)
      comment2 = FactoryBot.create(:comment, user: user, post: post)
      expect(user.comments.count).to eq(2)
    end
  end

  # Test User model helper methods
  describe "methods" do
    # Test admin? method returns true for admin role
    it "returns admin? as true for admin role" do
      user = FactoryBot.build(:user, role: 'admin')
      expect(user.admin?).to be true
    end

    # Test admin? method returns false for regular user role
    it "returns admin? as false for user role" do
      user = FactoryBot.build(:user, role: 'user')
      expect(user.admin?).to be false
    end

    # Test full_name method returns email when first_name is blank
    it "returns full_name as email when first_name is blank" do
      user = FactoryBot.build(:user, email: 'test@example.com')
      expect(user.full_name).to eq('test@example.com')
    end
  end
end
