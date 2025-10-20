namespace :friendly_id do
  desc "Generate slugs for existing records"
  task regenerate_slugs: :environment do
    puts "Generating slugs for existing records..."

    # Generate slugs for users
    User.find_each do |user|
      user.slug = nil
      user.save!
      puts "✓ Generated slug for user: #{user.email} -> #{user.slug}"
    end
    puts "✅ Generated slugs for #{User.count} users"

    # Generate slugs for expenses
    Expense.find_each do |expense|
      expense.slug = nil
      expense.save(validate: false)
      puts "✓ Generated slug for expense ##{expense.id} -> #{expense.slug}"
    end
    puts "✅ Generated slugs for #{Expense.count} expenses"

    puts "\n🎉 All slugs generated successfully!"
  end
end
