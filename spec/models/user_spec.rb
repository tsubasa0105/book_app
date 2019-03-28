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
end
