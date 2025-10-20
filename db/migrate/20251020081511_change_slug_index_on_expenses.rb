class ChangeSlugIndexOnExpenses < ActiveRecord::Migration[8.0]
  def change
    remove_index :expenses, :slug
    add_index :expenses, [ :user_id, :slug ], unique: true
  end
end
