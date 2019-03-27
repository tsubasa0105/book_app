# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  it "is valid with an email address and password" do
    user = User.new(
      email: "testtest@example.com",
      password: "password",
    )
    expect(user).to be_valid
  end

  it "is valid without an email address" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "is valid without a password" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "is invalid with a duplicate email address" do
    User.create(
      email: "testtest@example.com",
      password: "password",
    )
    user = User.new(
      email: "testtest@example.com",
      password: "password",
    )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  describe "#from_omniauth" do
    it "finds an existing user" do
      OmniAuth.config.mock_auth[:facebook] = nil
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
        provider: "facebook",
        uid: "283283",
        info: {
        email: "testtest@example.com",
        name: "tsubasa ishikawa"
        }
      )

      user = User.new(
        provider: "facebook",
        uid: 283283,
        email: "testtest@example.com",
        password: "password",
        password_confirmation: "password"
          )
      user.save

      omniauth_user = User.from_omniauth(OmniAuth.config.mock_auth[:facebook])
      expect(user).to eq(omniauth_user)
    end
  end

  describe "#new_with_session" do
    it "inserts a email data to user email if user email is blank" do
      session = {
        email: "testtest@example.com"
      }

      data = session

      user = User.new(
        provider: "facebook",
        uid: 283283,
        email: nil,
        password: "password",
        password_confirmation: "password"
      )

      user.email = data["email"]
      expect(user.email).to eq(data["email"])
    end
  end
end
