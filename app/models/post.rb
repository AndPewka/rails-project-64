class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: "User"

  has_many :comments, class_name: "PostComment", dependent: :destroy
  has_many :post_likes, dependent: :destroy
  has_many :liked_by_users, through: :post_likes, source: :user
end
