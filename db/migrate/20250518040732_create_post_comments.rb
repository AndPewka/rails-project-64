# frozen_string_literal: true

class CreatePostComments < ActiveRecord::Migration[8.0]
  def change
    create_table :post_comments do |t|
      t.references :post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.string :ancestry

      t.timestamps
    end
    add_index :post_comments, :ancestry
  end
end
