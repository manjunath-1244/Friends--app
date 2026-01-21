# Factory for Comment model
# Creates test comment records with required relationships.
FactoryBot.define do
  factory :comment do
    # Default comment content for testing
    content { "Nice post" }
    # Associates this comment with a user (the comment author)
    association :user
    # Associates this comment with a post (required relationship)
    association :post
  end
end
