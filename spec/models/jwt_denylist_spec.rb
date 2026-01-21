# Test suite for JwtDenylist model
# Tests JWT token revocation functionality.
require "rails_helper"

RSpec.describe JwtDenylist, type: :model do
  # Verify that JWT tokens can be stored in the denylist for revocation
  it "stores a revoked JWT" do
    token = JwtDenylist.create!(
      jti: "test-jti",
      exp: 1.day.from_now
    )

    # Verify the token was stored correctly
    expect(token.jti).to eq("test-jti")
  end
end
