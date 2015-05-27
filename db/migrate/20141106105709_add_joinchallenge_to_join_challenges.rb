class AddJoinchallengeToJoinChallenges < ActiveRecord::Migration
  def change
    add_column :join_challenges, :joinchallenge, :string
  end
end
