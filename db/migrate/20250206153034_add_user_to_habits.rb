class AddUserToHabits < ActiveRecord::Migration[8.0]
  # Add user reference column, assign previous habits to default user, enforce null
  def up
    add_reference :habits, :user, null: true, foreign_key: true
    default_user = User.create_with(password: "123456")
                       .find_or_create_by!(email_address: "user@user.com")
    Habit.update_all(user_id: default_user.id)
    change_column_null :habits, :user_id, false
  end

  def down
    remove_reference :habits, :user
  end
end
