# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    user
    sequence(:content) { |i| "content No.#{i}" }
  end
end
