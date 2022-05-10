class ScoresAddColumnScore < ActiveRecord::Migration[6.1]
  def change
    add_column(:scores, :score, :integer)
  end
end
