class CreateHangouts < ActiveRecord::Migration
  def change
    create_table :hangouts do |t|
      t.text :business_name
      t.text :business_location
      t.float :latitude
      t.float :longitude
      t.datetime :share_time

      t.timestamps
    end
  end
end
