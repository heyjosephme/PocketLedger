json.extract! expense, :id, :amount, :description, :expense_date, :expense_type, :category, :vendor, :notes, :created_at, :updated_at
json.url expense_url(expense, format: :json)
