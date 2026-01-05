FactoryBot.define do
  factory :friend do
    first_name { "John" }
    last_name { "Doe" }
    sequence(:email) { |n| "friend#{n}@example.com" }
    association :user
  end
end
