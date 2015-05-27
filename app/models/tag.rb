class Tag < ActiveRecord::Base
	has_many :tag_maps, dependent: :destroy
	validates :name, uniqueness: :true
	validates_associated :tag_maps
end
