# frozen_string_literal: true

class PostComment < ApplicationRecord
  has_ancestry orphan_strategy: :destroy, cache_depth: true

  belongs_to :post
  belongs_to :user

  validates :content, presence: true

  before_save :set_materialized_path2

  private

  def set_materialized_path2
    self.materialized_path2 = path.map(&:id).join('/')
  end
end
