require "rails_helper"

RSpec.describe JwtDenylist, type: :model do
  it "stores a revoked JWT" do
    token = JwtDenylist.create!(
      jti: "test-jti",
      exp: 1.day.from_now
    )

    expect(token.jti).to eq("test-jti")
  end
end
