require "rails_helper"

RSpec.describe Friend, type: :model do
  describe "validations" do
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

    it "is invalid without a first_name" do
      user = FactoryBot.create(:user)
      friend = Friend.new(
        last_name: "Reddy",
        email: "santhu@example.com",
        user: user
      )
      expect(friend).not_to be_valid
    end

    it "is invalid without an email" do
      user = FactoryBot.create(:user)
      friend = Friend.new(
        first_name: "Santhu",
        last_name: "Reddy",
        user: user
      )
      expect(friend).not_to be_valid
    end

    it "is invalid without a user" do
      friend = Friend.new(
        first_name: "Santhu",
        last_name: "Reddy",
        email: "santhu@example.com"
      )
      expect(friend).not_to be_valid
    end
  end

  describe "associations" do
    it "belongs to a user" do
      user = FactoryBot.create(:user)
      friend = FactoryBot.create(:friend, user: user)
      expect(friend.user).to eq(user)
    end
  end
end