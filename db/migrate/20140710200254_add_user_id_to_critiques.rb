class AddUserIdToCritiques < ActiveRecord::Migration
  def change
    add_column :critiques, :user_id, :integer
  end
end
