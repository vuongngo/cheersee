class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_for_oauth(auth)
    find_or_create_by!(uid: auth.uid, provider: auth.provider)
  end

  # def self.create_for_oauth(auth)
  # 	build(uid: auth.uid, provider: auth.provider, :token => auth.credentials.token)
  # end
end
