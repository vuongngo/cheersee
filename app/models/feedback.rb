class Feedback < ActiveRecord::Base
	
  belongs_to :reference
  belongs_to :time_management
  validates_presence_of :rate, :friendly, :fun, :confidence, :curiosity, :reference_id, :time_management_id
  validates_uniqueness_of :reference_id

end
