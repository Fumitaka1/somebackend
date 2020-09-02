FactoryBot.define do
  factory :bookmark do
    user
    post
    sequence(:name) { |n| "bookmark no.#{n}" }
  end
end
