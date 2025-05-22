# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: 'User'

  has_many :comments, class_name: 'PostComment', dependent: :destroy
  has_many :likes,           class_name: 'PostLike', dependent: :destroy
  has_many :liked_by_users,  through: :likes,        source: :user
end
