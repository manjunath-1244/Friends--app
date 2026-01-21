# Test suite for Friend model
# Tests validations and associations for user's friend records.
require "rails_helper"

RSpec.describe Friend, type: :model do
  # Test Friend model validations
  describe "validations" do
    # A valid friend record requires first_name, email, and association to user
    it "is valid with valid attributes" do
      user = FactoryBot.create(:user)
      friend = Friend.new(
        first_name: "Santhu",
        last_name: "Reddy",
        email: "santhu@example.com",
        user: user
      )
      expect(friend).to be_valid
    end

    # First name is a required field
    it "is invalid without a first_name" do
      user = FactoryBot.create(:user)
      friend = Friend.new(
        last_name: "Reddy",
        email: "santhu@example.com",
        user: user
      )
      expect(friend).not_to be_valid
    end

    # Email is a required field
    it "is invalid without an email" do
      user = FactoryBot.create(:user)
      friend = Friend.new(
        first_name: "Santhu",
        last_name: "Reddy",
        user: user
      )
      expect(friend).not_to be_valid
    end

    # User association is required (each friend belongs to a user)
    it "is invalid without a user" do
      friend = Friend.new(
        first_name: "Santhu",
        last_name: "Reddy",
        email: "santhu@example.com"
      )
      expect(friend).not_to be_valid
    end
  end

  # Test Friend model associations
  describe "associations" do
    # A friend belongs to a user (the owner of the friend list)
    it "belongs to a user" do
      user = FactoryBot.create(:user)
      friend = FactoryBot.create(:friend, user: user)
      expect(friend.user).to eq(user)
    end
  end
end