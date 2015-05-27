class AddSetchallengeToSetChallenges < ActiveRecord::Migration
  def change
    add_column :set_challenges, :setchallenge, :string
  end
end
