class CreateManageChallenges < ActiveRecord::Migration
  def change
    create_table :manage_challenges do |t|
      t.references :user, index: true
      t.references :set_challenge, index: true

      t.timestamps
    end
    add_index :manage_challenges, [:user_id, :set_challenge_id], unique: true
  end
end
