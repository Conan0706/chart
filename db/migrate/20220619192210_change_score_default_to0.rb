class ChangeScoreDefaultTo0 < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:scores, :score,0)
  end
end
