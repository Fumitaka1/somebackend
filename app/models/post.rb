class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true
  validates :content, length: { maximum: 4_000, too_long: 'は４，０００文字以下です。' }
end
