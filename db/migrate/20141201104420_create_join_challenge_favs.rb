class CreateJoinChallengeFavs < ActiveRecord::Migration
  def change
    create_table :join_challenge_favs do |t|
      t.references :join_challenge, index: :true
      t.references :user, index: :true

      t.timestamps
    end
  end
end
