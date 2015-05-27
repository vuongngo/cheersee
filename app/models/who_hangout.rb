class WhoHangout < ActiveRecord::Base
  belongs_to :hangout
  belongs_to :user
  validates :user_id, presence: :true, numericality: true
  validates :hangout_id, presence: :true, numericality: true
  validates_uniqueness_of :hangout_id, :scope => [:user_id]
end
