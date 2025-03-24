HabitLog.destroy_all
Habit.destroy_all
User.destroy_all

puts "Creating users…"
user = User.create!(email_address: "lucas@lucas.com", password: "123456")

puts "Creating habits…"
habit1 = Habit.create(name: 'Routine', user: user)
habit2 = Habit.create(name: 'Meditation', user: user)
habit3 = Habit.create(name: 'Yoga', user: user)
habit4 = Habit.create(name: 'Stretching', user: user)
habit5 = Habit.create(name: 'Git commit', user: user)

puts "Logging habits…"
today = Date.today
(-300..0).each do |n|
  habit1.habit_logs.create(log_date: today + n) if rand(100) < 70
  habit2.habit_logs.create(log_date: today + n) if rand(100) < 40
  habit3.habit_logs.create(log_date: today + n) if rand(100) < 50
  habit4.habit_logs.create(log_date: today + n) if rand(100) < 15
  habit5.habit_logs.create(log_date: today + n) if rand(100) < 30
end

puts "Seeding done!"
