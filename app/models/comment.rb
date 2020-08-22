class Comment < ApplicationRecord
  self.per_page = 30

  belongs_to :post

  validates :content, presence: true
  validates :content, length: { maximum: 400, too_long: 'は４００文字以下です。' }
end
