FactoryBot.define do
  factory :jwt_denylist do
    jti { "MyString" }
    exp { "2026-01-01 17:56:21" }
  end
end
