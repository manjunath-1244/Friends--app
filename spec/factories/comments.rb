FactoryBot.define do
  factory :comment do
    content { "Nice post" }
    association :user
    association :post
  end
end
