# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { "テスト名前" }
    memo { "テスト説明" }
    author { "テスト著者名" }
  end
end
