# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Books", type: :feature do
  before do
    @user = FactoryBot.create(:user, email: "testtest@example.com")
    @book = FactoryBot.create(:book)

    sign_in @user
  end

  scenario "creates a new book" do
    visit books_path
    expect {
      click_link "新規作成"
      fill_in "書籍名", with: "テスト書籍"
      fill_in "説明", with: "テスト説明"
      fill_in "著者名", with: "テスト著者名"
      attach_file "画像", "#{Rails.root}/spec/files/test_picture.jpg"
      click_button "登録する"

      expect(page).to have_content "書籍が作成されました。"
      expect(page).to have_content "テスト書籍"
    }.to change(Book, :count).by(1)
  end

  scenario "lists all books" do
    visit books_path
    expect(page).to have_content "書籍一覧"
  end

  scenario "shows a created book" do
    visit books_path(id: @book.id)
    expect(page).to have_content "テスト名前"
    expect(page).to have_content "テスト説明"
    expect(page).to have_content "テスト著者名"
  end

  scenario "updates a contents of a created book" do
    visit edit_book_path(id: @book.id)
    expect(page).to have_field "書籍名", with: "テスト名前"

    fill_in "説明", with: "説明の内容を変更します。"
    attach_file "画像", "#{Rails.root}/spec/files/test_picture.jpg"
    click_button "更新する"
    expect(page).to have_content "書籍が更新されました。"
    expect(page).to have_content "説明の内容を変更します。"
    expect(page).to have_css("img[src*='.jpg']")
  end

  scenario "deletes a created book" do
    visit books_path
    first(:link, "削除").click
    expect(page).to have_content "書籍を削除しました。"
  end
end
