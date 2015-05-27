class CreateSetChallenges < ActiveRecord::Migration
  def change
    create_table :set_challenges do |t|
      t.references :user, index: true
      t.text :post
      t.integer :time_span
      t.string :point_metric, index: true
      t.string :point_measure, index: true
      t.float :longitude, index: true
      t.float :latitude, index: true
      t.integer :no_of_fav
      t.boolean :international, default: :false
      t.datetime :end_time, index: true
      t.timestamps
    end
  end
end
