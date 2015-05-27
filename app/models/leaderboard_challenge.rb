class LeaderboardChallenge < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }	
  belongs_to :set_challenge
  belongs_to :first, :class_name => "JoinChallenge", :foreign_key => "first_place"
  belongs_to :second, :class_name => "JoinChallenge", :foreign_key => "second_place"
  belongs_to :third, :class_name => "JoinChallenge", :foreign_key => "third_place"
  mount_uploader :firstpic, FirstpicUploader 
  mount_uploader :secondpic, SecondpicUploader
  mount_uploader :thirdpic, ThirdpicUploader
  validates :set_challenge_id, uniqueness: :true
end
