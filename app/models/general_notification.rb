class GeneralNotification < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  belongs_to :user
  belongs_to :sender, :class_name => "User"
  belongs_to :set_challenge
  belongs_to :join_challenge
  belongs_to :reference
  validates_presence_of :user_id, :mes
end
