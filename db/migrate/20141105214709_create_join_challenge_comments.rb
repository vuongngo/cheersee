class CreateJoinChallengeComments < ActiveRecord::Migration
  def change
    create_table :join_challenge_comments do |t|
    	t.references :join_challenge, index: true
    	t.references :user
    	t.text :comment

      t.timestamps
    end
  end
end
