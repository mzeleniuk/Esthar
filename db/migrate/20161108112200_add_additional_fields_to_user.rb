class AddAdditionalFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :username, :string, null: false
    add_column :users, :date_of_birth, :date
    add_column :users, :phone, :integer
    add_column :users, :website, :string

    add_index :users, :username, unique: true
  end
end
