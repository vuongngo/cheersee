class CreateGeneralNotificationCounts < ActiveRecord::Migration
  def change
    create_table :general_notification_counts do |t|
      t.references :user, index: :true
      t.integer :unread_count
      
      t.timestamps
    end
  end
end
