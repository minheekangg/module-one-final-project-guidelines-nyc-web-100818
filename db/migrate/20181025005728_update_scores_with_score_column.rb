class UpdateScoresWithScoreColumn < ActiveRecord::Migration[5.0]
  def change
    add_column(:scores, :score, :integer)
  end
end
