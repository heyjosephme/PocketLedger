class AddRecurrenceToExpenses < ActiveRecord::Migration[8.0]
  def change
    add_column :expenses, :is_recurring, :boolean, default: false, null: false
    add_column :expenses, :recurrence_frequency, :string
    add_column :expenses, :recurrence_start_date, :date
    add_column :expenses, :recurrence_end_date, :date
    add_column :expenses, :parent_expense_id, :integer
    add_index :expenses, :parent_expense_id
    add_index :expenses, :is_recurring
  end
end
