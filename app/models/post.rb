class Post < ApplicationRecord

  self.per_page = 30

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :content, presence: true
  validates :content, length: { maximum: 4_000, too_long: 'は４，０００文字以下です。' }
end
