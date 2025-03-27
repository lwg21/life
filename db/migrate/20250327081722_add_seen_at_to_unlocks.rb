class AddSeenAtToUnlocks < ActiveRecord::Migration[8.0]
  def change
    add_column :unlocks, :seen_at, :datetime, default: nil
  end
end
