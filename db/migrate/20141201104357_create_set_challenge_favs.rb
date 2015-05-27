class CreateSetChallengeFavs < ActiveRecord::Migration
  def change
    create_table :set_challenge_favs do |t|
      t.references :set_challenge, index: :true
      t.references :user, index: :true

      t.timestamps
    end
  end
end
