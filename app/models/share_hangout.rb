class ShareHangout < ActiveRecord::Base
  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :content
  belongs_to :user 
  has_many :request_hangouts, dependent: :destroy
  has_many :share_hangout_mates, dependent: :destroy
  validates_presence_of :user_id, :share_time, :content, :longitude, :latitude
  validates_uniqueness_of :user_id, :scope => [:share_time]
  private
    def clear_share_hangout
      t = Time.current - 2.days
      @share_hangouts = ShareHangout.where("share_time < ?", t)
      @share_hangouts.destroy_all
    end
end
