class JoinChallenge < ActiveRecord::Base
  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :content
  default_scope -> { order('created_at DESC') }
  belongs_to :user
  belongs_to :set_challenge
  has_one :firstwinner, :class_name => "LeaderboardChallenge", :foreign_key => "first_place"
  has_one :first, :through => :firstwinner, :source => :join_challenge
  has_one :secondwinner, :class_name => "LeaderboardChallenge", :foreign_key => "second_place"
  has_one :second, :through => :secondwinner, :source => :join_challenge
  has_one :thirdwinner, :class_name => "LeaderboardChallenge", :foreign_key => "third_place"
  has_one :third, :through => :thirdwinner, :source => :join_challenge
  has_many :join_challenge_comments, dependent: :destroy
  has_many :join_challenge_favs, dependent: :destroy
  has_many :general_notifications, dependent: :destroy
  mount_uploader :joinchallenge, JoinchallengeUploader
  validates_presence_of :set_challenge_id, :user_id, :point, :longitude, :latitude, :content, :no_of_fav
  validates_uniqueness_of :set_challenge_id, :scope => [:user_id, :point]

end
