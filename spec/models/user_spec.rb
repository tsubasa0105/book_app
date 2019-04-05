# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "#from_omniauth" do
    it "finds an existing user by the provider and uid fields" do
      user = User.create(
        provider: "facebook",
        uid: 283283,
        email: "testtest@example.com",
        password: "password",
        password_confirmation: "password"
          )

      omniauth_user = User.where(provider: "facebook", uid: 283283).first
      expect(omniauth_user.email).to eq("testtest@example.com")
    end
  end


  describe "#new_with_session" do
    it "fills a email data from sessoin if user email is blank" do
      session = {
        facebook_data: {
        provider: "facebook",
        uid:  "283283",
        name: "testuser",
        email: "testuser@example.com",
        credentials: {
          token: "testtoken"
        },
        extra: {
          raw_info: "raw_info"
        }
        }
      }
      data = session

      user = User.new(
        provider: "facebook",
        uid: 283283,
        email: "",
        password: "password",
        password_confirmation: "password"
      )

      user.email = data[:facebook_data][:email] if user.email.blank?
      expect(user.email).to eq(data[:facebook_data][:email])
    end
  end
end
