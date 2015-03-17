class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title
      t.integer :user_id
      t.string :type
      t.string :status

      t.timestamps null: false
    end
    add_index :goals, :user_id
  end
end
