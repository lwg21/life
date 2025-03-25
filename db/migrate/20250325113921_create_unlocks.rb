class CreateUnlocks < ActiveRecord::Migration[8.0]
  def change
    create_table :unlocks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :goal, null: false, foreign_key: true
      t.timestamps
    end
    add_index :unlocks, [ :user_id, :goal_id ], unique: true
  end
end
