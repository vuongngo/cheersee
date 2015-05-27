class User < ActiveRecord::Base
  has_many :share_hangouts, dependent: :destroy
  has_many :share_hangout_mates, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :request_hangouts, dependent: :destroy
  has_many :who_hangouts, dependent: :destroy
  has_many :hangout_messages, dependent: :destroy
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :potential_relationships
  has_many :stranger, :through => :potential_relationships
  has_many :inverse_potential_relationships, :class_name => "PotentialRelationship", :foreign_key => "stranger_id"
  has_many :users, :through => :inverse_potential_relationships, :source => :user
  has_many :references
  has_many :sender, :through => :references
  has_many :pro_references, :class_name => "Reference", :foreign_key => "receiver_id"
  has_many :receiver, :through => :pro_references, :source => :user
  has_one :location, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_one :preference, dependent: :destroy
  has_one :reputation, dependent: :destroy
  has_many :set_challenges
  has_many :join_challenges
  has_many :manage_challenges, dependent: :destroy
  has_many :set_challenge_comments, dependent: :destroy
  has_many :join_challenge_comments, dependent: :destroy
  has_many :friendhashes, dependent: :destroy
  has_many :friend_messages, dependent: :destroy
  has_many :contact_mes, dependent: :destroy
  has_many :set_challenge_favs, dependent: :destroy
  has_many :join_challenge_favs, dependent: :destroy
  has_many :general_notifications, dependent: :destroy
  has_many :notifier, :through => :general_notifications
  has_many :make_general_notifications, :class_name => "GeneralNotification", :foreign_key => "sender_id"
  has_many :senders, :through => :make_general_notifications, :source => :user
  has_one :general_notification_count, dependent: :destroy
  has_one :message_notification, dependent: :destroy
  has_one :hangout_notification, dependent: :destroy
  has_one :user_address, dependent: :destroy
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  validates :name, presence: :true

  before_create :create_associated_records

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
      identity.update_attributes(:token => auth.credentials.token)
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  private

  def create_associated_records
    return unless self.id.nil?
    self.create_profile
    self.create_reputation(time_early: "1", time_late: "0", never_come: "0", rate_av: "100", friendly_av: "100", fun_av: "100", confidence_av: "100", curiosity_av: "100", number_of_rate: "1")
    self.create_message_notification(unread_count: "0")
    self.create_hangout_notification(unread_count: "0")
    self.create_general_notification_count(unread_count: "0")
    self.create_location(latitude: 37.77711868286133, longitude: -112.41963954760234, user_time_zone: 'Eastern Time (US & Canada)')
    self.create_user_address
    self.create_preference
  end
end