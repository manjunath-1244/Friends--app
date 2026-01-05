require "rails_helper"

RSpec.describe User, type: :model do
  describe "factory" do
    it "has a valid factory" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
  end

  describe "validations" do
    it "is invalid without an email" do
      user = FactoryBot.build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it "is invalid with an invalid email format" do
      user = FactoryBot.build(:user, email: "not-an-email")
      expect(user).not_to be_valid
    end

    it "is invalid without a password" do
      user = FactoryBot.build(:user, password: nil)
      expect(user).not_to be_valid
    end
  end

  describe "associations" do
    it "has many friends" do
      user = FactoryBot.create(:user)
      friend1 = FactoryBot.create(:friend, user: user)
      friend2 = FactoryBot.create(:friend, user: user)
      expect(user.friends.count).to eq(2)
    end

    it "has many posts" do
      user = FactoryBot.create(:user)
      post1 = FactoryBot.create(:post, user: user)
      post2 = FactoryBot.create(:post, user: user)
      expect(user.posts.count).to eq(2)
    end

    it "has many comments" do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)
      comment1 = FactoryBot.create(:comment, user: user, post: post)
      comment2 = FactoryBot.create(:comment, user: user, post: post)
      expect(user.comments.count).to eq(2)
    end
  end

  describe "methods" do
    it "returns admin? as true for admin role" do
      user = FactoryBot.build(:user, role: 'admin')
      expect(user.admin?).to be true
    end

    it "returns admin? as false for user role" do
      user = FactoryBot.build(:user, role: 'user')
      expect(user.admin?).to be false
    end

    it "returns full_name as email when first_name is blank" do
      user = FactoryBot.build(:user, email: 'test@example.com')
      expect(user.full_name).to eq('test@example.com')
    end
  end
end
