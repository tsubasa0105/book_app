# frozen_string_literal: true

require "rails_helper"

RSpec.feature "User", type: :feature do
  scenario "user creates an account" do
    user = User.new(
      email: "testtest@example.com",
      password: "password"
    )
    visit root_path
    click_link "サインアップ"
    expect {
      fill_in "Eメール", with: user.email
      fill_in "パスワード", with: user.password
      fill_in "user_password_confirmation", with: user.password
      click_button "アカウント登録"

      expect(page).to have_content "アカウント登録が完了しました。"
    }.to change(User, :count).by(1)
  end

  scenario "user updates an account" do
    user = User.create(
      email: "testtest@example.com",
      password: "password"
    )
    sign_in user
    visit root_path

    click_link "プロフィールを編集する"
    attach_file "プロフィール写真", "#{Rails.root}/spec/files/test_avatar_picture.jpg"
    fill_in "Eメール", with: "change_email@example.com"
    fill_in "現在のパスワード", with: "password"
    click_button "更新"

    expect(page).to have_content "アカウント情報を変更しました。"
    expect(page).to have_css("img[src*='test_avatar_picture.jpg']")
  end
end
