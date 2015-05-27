class CreateLeaderboardChallenges < ActiveRecord::Migration
  def change
    create_table :leaderboard_challenges do |t|
      t.references :set_challenge, index: true
      t.integer :first_place
      t.integer :first_point
      t.text :first_badge
      t.string :firstpic
      t.integer :second_place
      t.integer :second_point
      t.text :second_badge
      t.string :secondpic
      t.integer :third_place
      t.integer :third_point
      t.text :third_badge
      t.string :thirdpic
      t.timestamps
    end
  end
end
