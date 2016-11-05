class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.integer :user_id
      t.string :subject
      t.date :due_date
      t.integer :recurrence
      t.boolean :is_complete
      t.integer :position
      t.datetime :completed_at

      t.timestamps
    end
  end
end
