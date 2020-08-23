# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  # PASSWORD_REGEX = %r{\A[\w[\(\)\[\]\{\}\.\?\+\-\*\|\\/][~!@#$%^&=:;<>,]]+\Z}.freeze

  validates :email, format: { with: EMAIL_REGEX }

  # deviseによって作られたカラムに対して、独自のバリデーションを追加するとうまく動かない
  # validates :password, format: { with: PASSWORD_REGEX }

  validates :email, length: { maximum: 250 }
end
