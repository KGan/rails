class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.integer :commentable_id, null: false
      t.string :commentable_type, null:false
      t.integer :user_id, null: false, index: true
      t.integer :post_id, null:false, index: true

      t.timestamps null: false
    end
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
