class AddBodyToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :body, :text, null: false
  end
end
