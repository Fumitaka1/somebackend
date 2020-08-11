# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,:validatable
  include DeviseTokenAuth::Concerns::User

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  PASSWORD_REGEX = %r{\A[\w[\(\)\[\]\{\}\.\?\+\-\*\|\\/][~!@#$%^&=:;<>,]]+\Z}.freeze

  validates :email, format: { with: EMAIL_REGEX }
  validates :password, format: { with: PASSWORD_REGEX }

  validates :email, :password, presence: true

  validates :email, length: { maximum: 250 }
  # validates :password, length: { in: 6..128 }

  has_many :posts, dependent: :destroy
end
