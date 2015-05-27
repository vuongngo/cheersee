class CreateJoinChallenges < ActiveRecord::Migration
  def change
    create_table :join_challenges do |t|
      t.references :user, index: true
      t.references :set_challenge, index: true
      t.integer :point
      t.float :longitude
      t.float :latitude
      t.text :content
      t.integer :no_of_fav

      t.timestamps
    end
  end
end
