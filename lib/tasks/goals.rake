namespace :goals do
  desc "Populate the database with goals (add new)"
  task update: :environment do
    goals_data = [
      {
        name: "3-day streak",
        code: "streak_day_3",
        description: "Do a habit 3 days in a row"
      },
      {
        name: "7-day streak",
        code: "streak_day_7",
        description: "Do a habit 7 days in a row"
      },
      {
        name: "15-day streak",
        code: "streak_day_15",
        description: "Do a habit 15 days in a row"
      },
      {
        name: "30-day streak",
        code: "streak_day_30",
        description: "Do a habit 30 days in a row"
      },
      {
        name: "Full month",
        code: "streak_calendar_month_1",
        description: "Do a habit every day for a calendar month"
      }
    ]

    goals_data.each do |data|
      goal = Goal.find_by(code: data[:code])
      if goal
        goal.update!(data)
        puts "Updated #{goal.code}"
      else
        new_goal = Goal.create!(data)
        puts "Created #{new_goal.code}"
      end
    end
  end
end
