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

  test "password below minimum length is rejected and valid password is accepted" do
    short_password_user = User.new(
      email: "short-password@example.com",
      password: "short",
      password_confirmation: "short"
    )

    assert_not short_password_user.valid?
    assert_includes short_password_user.errors[:password], "is too short (minimum is #{User::MINIMUM_PASSWORD_LENGTH} characters)"

    valid_password_user = User.new(
      email: "valid-password@example.com",
      password: "secret-password",
      password_confirmation: "secret-password"
    )

    assert valid_password_user.valid?
  end

  test "password reset request uses configured canonical application base URL" do
    user = create_user(account_state: :pending, email: "canonical-reset@example.com")
    previous_base_url = ENV["APP_BASE_URL"]
    ENV["APP_BASE_URL"] = "https://may-december-staging.onrender.com"
    ActionMailer::Base.deliveries.clear

    perform_enqueued_jobs do
      post password_reset_requests_path, params: { email: user.email }
    end

    message = ActionMailer::Base.deliveries.last
    assert message
    assert_includes message.body.to_s, "https://may-december-staging.onrender.com/password/reset/"
    assert_not_includes message.body.to_s, "example.org/password/reset/"
  ensure
    ENV["APP_BASE_URL"] = previous_base_url
  end

  test "password reset request shows generic confirmation on sign in" do
    create_user(account_state: :pending, email: "reset-confirmation@example.com")

    post password_reset_requests_path, params: { email: "reset-confirmation@example.com" }
    assert_redirected_to new_session_path

    follow_redirect!
    assert_response :success
    assert_includes response.body, "If that email exists, password recovery instructions have been prepared."
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

  test "invalid password reset token is rejected" do
    patch password_reset_path("invalid-token"), params: {
      user: {
        password: "new-secret-password",
        password_confirmation: "new-secret-password"
      }
    }

    assert_redirected_to new_password_reset_path
  end

  test "expired password reset token is rejected" do
    user = create_user(account_state: :pending, email: "expired-reset@example.com")
    token = user.generate_token_for(:password_reset)

    travel 31.minutes do
      patch password_reset_path(token), params: {
        user: {
          password: "new-secret-password",
          password_confirmation: "new-secret-password"
        }
      }

      assert_redirected_to new_password_reset_path
    end

    assert user.reload.authenticate("secret-password")
  end

  test "invalid sign in credentials are rejected without creating an authenticated session" do
    user = create_user(account_state: :active, email: "invalid-login@example.com")

    post session_path, params: { email: user.email, password: "wrong-password" }
    assert_response :unprocessable_entity

    get members_dashboard_path
    assert_redirected_to new_session_path
  end

  test "case normalized duplicate email registration is rejected" do
    create_user(account_state: :pending, email: "Duplicate.Member@Example.com")

    assert_no_difference("User.count") do
      post registration_path, params: {
        user: {
          email: "duplicate.member@example.com",
          password: "another-secret-password",
          password_confirmation: "another-secret-password"
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "anonymous user cannot modify registration completion state" do
    user = create_user(account_state: :pending, email: "anonymous-registration@example.com", registration_completed_at: nil)

    patch registration_path, params: { commit_registration: "1" }

    assert_redirected_to new_session_path
    assert_not user.reload.registration_complete?
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

  test "active session is denied after authoritative account state changes to suspended" do
    user = create_user(account_state: :active, email: "stale-session@example.com")
    sign_in(user)

    get members_dashboard_path
    assert_response :success

    user.update!(account_state: :suspended)

    get members_dashboard_path
    assert_redirected_to root_path
  end

  private

  def create_user(account_state:, email:, registration_completed_at: Time.current)
    User.create!(
      email: email,
      password: "secret-password",
      password_confirmation: "secret-password",
      account_state: account_state,
      registration_completed_at: registration_completed_at
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
