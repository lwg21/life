json.calendar render(partial: "habits/calendar", formats: :html, locals: @calendar_data)
json.habits render(partial: "habits/habit", formats: :html, locals: { habit: @habit, date_range: @date_range, logs_by_habit_and_date: @logs_by_habit_and_date })
