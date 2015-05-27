class CreateMessageNotifications < ActiveRecord::Migration
  def change
    create_table :message_notifications do |t|
      t.references :user, index: :true
      t.integer :unread_count

      t.timestamps
    end
  end
end
