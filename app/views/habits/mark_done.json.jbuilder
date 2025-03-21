json.calendar render(partial: "habits/calendar", formats: :html, locals: @calendar_data)
json.habits render(partial: "habits/habits", formats: :html, locals: { habits: @habits })
