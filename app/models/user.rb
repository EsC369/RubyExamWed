class User < ActiveRecord::Base
  has_secure_password
  has_many :posts
	has_many :likes
  # has_many :groups
  # has_many :joins, dependent: :destroy
  has_many :posts_liked, through: :likes, source: :post
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
end
