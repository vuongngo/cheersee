class PotentialRelationship < ActiveRecord::Base
	belongs_to :user
	belongs_to :stranger, :class_name => "User" 
	validates_uniqueness_of :user_id, :scope => [:stranger_id]
end
