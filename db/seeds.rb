HabitLog.destroy_all
Habit.destroy_all
User.destroy_all

puts "Creating users…"
user = User.create(email_address: "m@m.com", password: "123456")

puts "Creating habits…"
habit1 = Habit.create(name: 'Routine', user: user)
habit2 = Habit.create(name: 'Meditation', user: user)
habit3 = Habit.create(name: 'Yoga', user: user)

puts "Logging habits…"
today = Date.today
(-30..0).each do |n|
  habit1.habit_logs.create(log_date: today + n) if rand(100) < 70
  habit2.habit_logs.create(log_date: today + n) if rand(100) < 40
  habit3.habit_logs.create(log_date: today + n) if rand(100) < 50
end

puts "Seeding done!"
