class CreateCritiques < ActiveRecord::Migration
  def change
    create_table :critiques do |t|
      t.text :comment, null: false
      t.integer :draft_id, null: false
    end
  end
end
