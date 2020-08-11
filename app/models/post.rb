class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true
  validates :content, length: { maximum: 40_000, too_long: 'は４０，０００文字以下です。' }
end
