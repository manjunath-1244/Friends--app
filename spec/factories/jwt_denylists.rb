# Factory for JwtDenylist model
# Creates test JWT token denylists for testing token revocation.
FactoryBot.define do
  factory :jwt_denylist do
    # JWT Token ID (unique identifier for the revoked token)
    jti { "MyString" }
    # Expiration timestamp for the revoked token
    exp { "2026-01-01 17:56:21" }
  end
end
