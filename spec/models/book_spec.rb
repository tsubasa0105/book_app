# frozen_string_literal: true

require "rails_helper"

RSpec.describe Book, type: :model do
  it "is valid with a title, a memo and an author" do
    book = Book.new(
      title: "testtitle",
      memo: "testmemo",
      author: "testauthor",
    )
    expect(book).to be_valid
  end

  it "is valid with a title" do
    book = Book.new(title: nil)
    book.valid?
    expect(book.errors[:title]).to include("を入力してください")
  end

  it "is valid with a memo" do
    book = Book.new(memo: nil)
    book.valid?
    expect(book.errors[:memo]).to include("を入力してください")
  end

  it "is valid with an author" do
    book = Book.new(author: nil)
    book.valid?
    expect(book.errors[:author]).to include("を入力してください")
  end

  it "is valid with a picture under 2megabytes" do
    expect(File.size("#{Rails.root}/spec/files/test_picture.jpg")).to be <= 2.megabytes
  end
end
