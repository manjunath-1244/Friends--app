# Factory for Post model
# Creates test post records with default content.
FactoryBot.define do
  factory :post do
    # Default post content for testing
    content { "Sample post content" }
    # Associates this post with a user (required relationship)
    association :user
  end
end
