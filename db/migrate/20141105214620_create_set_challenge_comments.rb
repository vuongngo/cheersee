class CreateSetChallengeComments < ActiveRecord::Migration
  def change
    create_table :set_challenge_comments do |t|
    	t.references :set_challenge, index: true
    	t.references :user
    	t.text :comment

      t.timestamps
    end
  end
end
