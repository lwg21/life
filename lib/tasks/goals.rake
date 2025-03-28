namespace :goals do
  desc "Delete all goals and unlocks"
  task delete: :environment do
    Goal.destroy_all
  end

  desc "Check all users for all goals"
  task check: :environment do
    User.all.each { |user| user.check_goals }
  end

  desc "Hide all unlocked goals (set seen_at to nil)"
  task hide: :environment do
    Unlock.update_all(seen_at: nil)
  end

  desc "Populate the database with goals (add new)"
  task update: :environment do
    goals_data = [
      {
        name: "3-day streak",
        code: "streak-day-3",
        category: "1:streak",
        target_value: 3,
        description: "Do a habit 3 days in a row"
      }
      # {
      #   name: "7-day streak",
      #   code: "streak-day-7",
      #   category: "1:streak",
      #   target_value: 7,
      #   description: "Do a habit 7 days in a row"
      # },
      # {
      #   name: "15-day streak",
      #   code: "streak-day-15",
      #   category: "1:streak",
      #   target_value: 15,
      #   description: "Do a habit 15 days in a row"
      # },
      # {
      #   name: "30-day streak",
      #   code: "streak-day-30",
      #   category: "1:streak",
      #   target_value: 30,
      #   description: "Do a habit 30 days in a row"
      # },
      # {
      #   name: "Full month",
      #   code: "streak-calendar-month-1",
      #   category: "2:specials",
      #   target_value: 1,
      #   description: "Do a habit every day for a calendar month"
      # },
      # {
      #   name: "Weekend warrior",
      #   code: "weekend-warrior",
      #   category: "2:specials",
      #   target_value: 1,
      #   description: "Do a habit every day for a calendar month"
      # },
      # {
      #   name: "Monday monk",
      #   code: "monday-monk",
      #   category: "2:specials",
      #   target_value: 1,
      #   description: "Do a habit every day for a calendar month"
      # }
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
