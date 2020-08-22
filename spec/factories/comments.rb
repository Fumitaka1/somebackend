FactoryBot.define do
  factory :comment do
    post
    sequence(:content) { |i| "content No.#{i}" }
  end
end
