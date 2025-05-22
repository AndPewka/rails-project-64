# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :created_posts, class_name: 'Post', foreign_key: :creator_id, dependent: :destroy
  has_many :likes,       class_name: 'PostLike', dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
end
