# frozen_string_literal: true

require "rails_helper"

RSpec.feature "omniauth via facebook", type: :feature do
  before do
    OmniAuth.config.mock_auth[:facebook] = nil
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      provider: "facebook",
      uid:  "283283",
      info: {
        name: "testuser",
        email: "testuser@example.com"
      },
      credentials: {
        token: "testtoken"
      }
    )

    visit root_path
  end

  scenario "when user signs up via facebook omniauth,the number of users increases" do
    expect {
      click_link "facebookでログイン"
    }.to change(User, :count).by(1)
  end
end
