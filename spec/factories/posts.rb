# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    user
    sequence(:content) { |i| "post No.#{i}" }
  end
end
