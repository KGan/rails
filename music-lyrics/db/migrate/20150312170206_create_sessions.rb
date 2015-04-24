class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :user_id
      t.string :session_token, null: false, unique: true
      t.string :location
      t.string :user_agent

      t.timestamps null: false
    end
    add_index :sessions, :user_id
  end
end
