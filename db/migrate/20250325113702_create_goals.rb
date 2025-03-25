class CreateGoals < ActiveRecord::Migration[8.0]
  def change
    create_table :goals do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :description
      t.timestamps
    end
    add_index :goals, :code, unique: true
  end
end
