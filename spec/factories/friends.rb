# Factory for Friend model
# Creates test friend records with default attributes.
FactoryBot.define do
  factory :friend do
    # Default first name for test friends
    first_name { "John" }
    # Default last name for test friends
    last_name { "Doe" }
    # Generate unique email addresses for each friend (friend1@example.com, friend2@example.com, etc.)
    sequence(:email) { |n| "friend#{n}@example.com" }
    # Associates this friend with a user (required relationship)
    association :user
  end
end
