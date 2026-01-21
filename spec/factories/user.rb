# Factory for User model
# Creates test users with default attributes for RSpec tests.
FactoryBot.define do
  factory :user do
    # Generate unique email addresses for each user (user1@example.com, user2@example.com, etc.)
    sequence(:email) { |n| "user#{n}@example.com" }
    # Default password for testing authentication
    password { "password123" }
    # Default role is regular user (not admin)
    role { "user" }
  end
end
