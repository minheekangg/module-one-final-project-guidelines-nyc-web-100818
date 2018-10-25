class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.integer :user_id # foreign key
      t.integer :game_id # foreign key
      t.integer :score
    end
  end
end
