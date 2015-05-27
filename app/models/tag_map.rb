class TagMap < ActiveRecord::Base
	belongs_to :user
	belongs_to :tag
	validates :user_id, presence: :true, numericality: true
	validates :tag_id, presence: :true, numericality: true
	validates_uniqueness_of :user_id, :scope => [:tag_id]
end
