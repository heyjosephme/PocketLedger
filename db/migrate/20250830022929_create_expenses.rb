class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.decimal :amount
      t.text :description
      t.date :expense_date
      t.integer :expense_type
      t.string :category
      t.string :vendor
      t.text :notes

      t.timestamps
    end
  end
end
