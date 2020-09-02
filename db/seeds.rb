require 'faker'

I18n.locale = :ja
Faker::Config.locale = :ja
Faker::Internet.email # => "ransom_blanda@auer.name"

User.create!(
  # name: 'サンプル太郎',
  email: 'sample@example.com',
  password: 'sample-password'
)

User.create!(
  # name: 'admin',
  email: 'admin@example.com',
  password: 'admin-password',
  # admin: true
)

100.times do |n|
  User.create!(
    # name: "#{Faker::Name.name}@#{Faker::Job.position} #{n}",
    email: Faker::Internet.email,
    password: 'a' * 8
  )
end

200.times do |_n|
  Post.create!(
    # title: Faker::Lorem.sentence,
    content: Faker::Lorem.sentence(word_count: 10),
    user_id: Random.rand(1..100)
  )
end

