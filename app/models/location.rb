class Location < ActiveRecord::Base
  belongs_to :user
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :user_id, presence: :true, uniqueness: :true
end
