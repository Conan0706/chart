class UserEditGoalColumn < ActiveRecord::Migration[6.1]
  def change
    change_column(:users, :goal, :integer, default: 0)
  end
end
