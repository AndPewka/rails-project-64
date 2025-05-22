# frozen_string_literal: true

class AddMaterializedPath2ToPostComments < ActiveRecord::Migration[8.0]
  def change
    add_column :post_comments, :materialized_path2, :string
  end
end
