class CreateMyMetrics < ActiveRecord::Migration
  def change
    create_table :my_metrics do |t|
      t.integer :no_of_user
      t.integer :no_of_challenge
      t.integer :no_of_join_challenge
      t.integer :no_of_share_meetup
      t.integer :no_of_hangout
      t.integer :no_of_reference
      t.integer :no_of_location_search
      t.date :every_day

      t.timestamps
    end
  end
end
