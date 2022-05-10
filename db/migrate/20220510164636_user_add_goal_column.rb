class UserAddGoalColumn < ActiveRecord::Migration[6.1]
  def change
    add_column(:users, :goal, :integer)
  end
end
