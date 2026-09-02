require "test_helper"

class RegistrationAuthorizationTest < ActionDispatch::IntegrationTest
  test "registration saves step one as pending and can be resumed after sign in" do
    assert_difference("User.count", 1) do
      post registration_path, params: {
        user: {
          email: "new-member@example.com",
          password: "secret-password",
          password_confirmation: "secret-password"
        }
      }
    end

    user = User.order(:created_at).last

    assert user.pending?
    assert_not user.registration_complete?
    assert_redirected_to edit_registration_path

    delete session_path
    post session_path, params: { email: user.email, password: "secret-password" }
    assert_redirected_to edit_registration_path

    patch registration_path, params: { commit_registration: "1" }
    assert_redirected_to root_path
    assert user.reload.registration_complete?
  end

  test "password reset token updates password and invalidates the old token" do
    user = create_user(account_state: :pending, email: "recover@example.com")
    token = user.generate_token_for(:password_reset)

    patch password_reset_path(token), params: {
      user: {
        password: "new-secret-password",
        password_confirmation: "new-secret-password"
      }
    }

    assert_redirected_to root_path
    assert user.reload.authenticate("new-secret-password")
    assert_nil User.find_by_token_for(:password_reset, token)
  end

  test "anonymous user cannot access restricted member dashboard" do
    get members_dashboard_path

    assert_redirected_to new_session_path
  end

  test "pending member cannot access restricted member dashboard" do
    user = create_user(account_state: :pending, email: "pending@example.com")
    sign_in(user)

    get members_dashboard_path

    assert_redirected_to root_path
  end

  test "suspended member cannot access restricted member dashboard" do
    user = create_user(account_state: :suspended, email: "suspended@example.com")
    sign_in(user)

    get members_dashboard_path

    assert_redirected_to root_path
  end

  test "active member can access restricted member dashboard" do
    user = create_user(account_state: :active, email: "active@example.com")
    sign_in(user)

    get members_dashboard_path

    assert_response :success
    assert_includes response.body, "restricted area"
  end

  private

  def create_user(account_state:, email:)
    User.create!(
      email: email,
      password: "secret-password",
      password_confirmation: "secret-password",
      account_state: account_state,
      registration_completed_at: Time.current
    )
  end

  def sign_in(user)
    post session_path, params: {
      email: user.email,
      password: "secret-password"
    }

    assert_redirected_to root_path
  end
end
