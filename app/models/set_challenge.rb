class SetChallenge < ActiveRecord::Base
  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :post
  default_scope -> { order('created_at DESC') }
  belongs_to :user
  has_many :join_challenges, dependent: :destroy
  has_one :leaderboard_challenge, dependent: :destroy
  has_many :set_challenge_comments, dependent: :destroy
  has_many :manage_challenges, dependent: :destroy
  has_many :set_challenge_favs, dependent: :destroy
  has_many :general_notifications, dependent: :destroy
  mount_uploader :setchallenge, SetchallengeUploader
  validates_presence_of :post, :time_span, :point_metric, :point_measure, :longitude, :latitude, :user_id, :no_of_fav
  validates :time_span, numericality: true
  validates_uniqueness_of :user_id, :scope => [:post, :time_span]
  before_create :create_associated_records

  def create_associated_records
    return unless self.id.nil?
    if self.point_measure == "highest"
    self.create_leaderboard_challenge(first_place: "0", first_point: "0", first_badge: "Goldust", firstpic: nil, second_place: "0", second_point: "0", second_badge: "Silver-wind", secondpic: nil, third_place: "0", third_point: "0", third_badge: "Bronze-arm", thirdpic: nil)
    elsif
    self.create_leaderboard_challenge(first_place: "0", first_point: "1000000", first_badge: "Goldust", firstpic: nil, second_place: "0", second_point: "1000000", second_badge: "Silver-wind", secondpic: nil, third_place: "0", third_point: "100000", third_badge: "Bronze-arm", thirdpic: nil)
    end
  end

  def latest_comments
    set_challenge_comments.order(created_at: :desc).limit(5)
  end
end
