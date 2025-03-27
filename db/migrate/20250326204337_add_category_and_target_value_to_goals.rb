class AddCategoryAndTargetValueToGoals < ActiveRecord::Migration[8.0]
  def change
    add_column :goals, :category, :string
    add_column :goals, :target_value, :integer
  end
end
