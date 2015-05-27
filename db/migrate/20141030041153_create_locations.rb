class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :user, index: true
      t.float :latitude
      t.float :longitude
      t.string :user_time_zone

      t.timestamps
    end
  end
end
