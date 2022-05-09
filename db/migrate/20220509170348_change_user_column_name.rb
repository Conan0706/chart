class ChangeUserColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :password_dogest, :password_digest
  end
end
