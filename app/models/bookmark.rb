class Bookmark < ApplicationRecord
  self.per_page = 30

  belongs_to :post
  belongs_to :user

  validates :name, presence: true
  validates :name, length: { maximum: 100, too_long: 'は１００文字以下です。' }
end
