namespace :goals do
  desc "Populate the database with goals (add new)"
  task populate: :environment do
    goal_data = [
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
        name: "Full month",
        code: "streak_calendar_month_1",
        description: "Do a habit every day for a calendar month"
      }
    ]
    # TODO: make idempotent
    goal_data.each { |data| Goal.create!(data) }
  end
end
