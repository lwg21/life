HabitLog.destroy_all
Habit.destroy_all
Goal.destroy_all
User.destroy_all

puts "Creating users…"
user1 = User.create!(email_address: "lucas@lucas.com", password: "123456")
user2 = User.create!(email_address: "paul@paul.com", password: "123456")

puts "Creating goals…"
goal_data = [
  {
    name: "3-day streak",
    code: :streak_day_3,
    description: "Do a habit 3 days in a row"
  },
  {
    name: "7-day streak",
    code: :streak_day_7,
    description: "Do a habit 7 days in a row"
  },
  {
    name: "15-day streak",
    code: :streak_day_15,
    description: "Do a habit 15 days in a row"
  },
  {
    name: "Full month",
    code: :streak_calendar_month_1,
    description: "Do a habit every day for a calendar month"
  }
]
goal_data.each { |data| Goal.create!(data) }

puts "Creating habits…"
habit1 = Habit.create!(name: 'Routine', user: user1)
habit2 = Habit.create!(name: 'Meditation', user: user1)
habit3 = Habit.create!(name: 'Yoga', user: user1)
habit4 = Habit.create!(name: 'Stretching', user: user1)
habit5 = Habit.create!(name: 'Git commit', user: user1)
habit6 = Habit.create!(name: 'Swimming', user: user2)
habit7 = Habit.create!(name: 'Cycling', user: user2)

puts "Logging habits…"
today = Date.today
(-80..0).each do |n|
  habit1.habit_logs.create!(log_date: today + n) if rand(100) < 70
  habit2.habit_logs.create!(log_date: today + n) if rand(100) < 40
  habit3.habit_logs.create!(log_date: today + n) if rand(100) < 50
  habit4.habit_logs.create!(log_date: today + n) if rand(100) < 15
  habit5.habit_logs.create!(log_date: today + n) if rand(100) < 30
  habit6.habit_logs.create!(log_date: today + n) if rand(100) < 30
  habit7.habit_logs.create!(log_date: today + n) if rand(100) < 40
end

puts "Seeding done!"
