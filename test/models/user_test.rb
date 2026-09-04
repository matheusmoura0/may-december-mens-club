require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "new users default to pending" do
    user = User.new(
      email: "member@example.com",
      password: "secret-password",
      password_confirmation: "secret-password"
    )

    assert user.pending?
  end

  test "email is normalized before validation" do
    user = User.create!(
      email: "  MEMBER@Example.COM ",
      password: "secret-password",
      password_confirmation: "secret-password"
    )

    assert_equal "member@example.com", user.email
  end
end
