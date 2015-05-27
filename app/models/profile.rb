class Profile < ActiveRecord::Base
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
  validates :user_id, presence: :true, uniqueness: :true
end
