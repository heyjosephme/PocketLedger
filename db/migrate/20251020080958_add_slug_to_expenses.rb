class AddSlugToExpenses < ActiveRecord::Migration[8.0]
  def change
    add_column :expenses, :slug, :string
    add_index :expenses, :slug, unique: true
  end
end
