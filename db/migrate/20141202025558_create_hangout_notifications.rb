class CreateHangoutNotifications < ActiveRecord::Migration
  def change
    create_table :hangout_notifications do |t|
      t.references :user, index: :true
      t.integer :unread_count

      t.timestamps
    end
  end
end
