class ChangeScoreDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:scores, :score,1)
  end
end
