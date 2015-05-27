class CreateGeneralNotifications < ActiveRecord::Migration
  def change
    create_table :general_notifications do |t|
      t.references :user, index: :true
      t.integer :sender_id, index: :true
      t.string :mes
      t.integer :join_challenge_id
      t.integer :set_challenge_id
      t.integer :reference_id
      
      t.timestamps
    end
  end
end
