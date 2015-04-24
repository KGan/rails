class CreateAnswerChoices < ActiveRecord::Migration
  def change
    create_table :answer_choices do |t|
      t.integer :question_id
      t.text :choice

      t.timestamps
    end

    add_index :answer_choices, :choice
  end
end
