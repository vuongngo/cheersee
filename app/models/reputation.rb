class Reputation < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :time_early, :time_late, :never_come, :rate_av, :friendly_av, :fun_av, :confidence_av, :curiosity_av, :number_of_rate
  validates_uniqueness_of :user_id
  validates :rate_av, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100}
end
