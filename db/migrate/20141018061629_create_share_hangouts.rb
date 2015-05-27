class CreateShareHangouts < ActiveRecord::Migration
  def change
    create_table :share_hangouts do |t|
      t.text :content
      t.references :user, index: true
      t.datetime :share_time, null: false
      t.string :business_location, index: true
      t.float :longitude
      t.float :latitude
      t.string :business_name, index: true
      t.boolean :notify_friend, :default => true
      t.boolean :open_nearby, :default => false

      t.timestamps
    end
    add_index :share_hangouts, [:user_id, :created_at]
  end
end
