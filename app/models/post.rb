class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :comments, class_name: "PostComment", dependent: :destroy
end
