class AddAncestryDepthToPostComments < ActiveRecord::Migration[8.0]
  def change
    add_column :post_comments, :ancestry_depth, :integer
  end
end
