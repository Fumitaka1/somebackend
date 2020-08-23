FactoryBot.define do
  factory :comment do
    post
    user
    sequence(:content) { |i| "content No.#{i}" }
  end
end
