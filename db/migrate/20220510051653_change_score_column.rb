class ChangeScoreColumn < ActiveRecord::Migration[6.1]
  def change
    change_column(:scores, :date, :date)
  end
end
