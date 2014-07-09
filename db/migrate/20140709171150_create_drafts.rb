class CreateDrafts < ActiveRecord::Migration
  def change
    create_table :drafts do |t|
      t.string :title, null: false
      t.integer :user_id
      t.integer :genre_id
      t.string :restriction, null: false
      t.text :summary, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end
