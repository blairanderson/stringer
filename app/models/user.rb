class User < ActiveRecord::Base
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable
  # TODO: enable :confirmable after email is setup.

  has_many :user_feeds
  has_many :feeds, through: :user_feeds

  has_many :user_stories
  has_many :stories, -> { includes(:user_stories).order(published: :desc) }, through: :feeds

  has_many :messages, -> { order(created_at: :asc) }, dependent: :destroy
  has_many :schedules

  has_many :identities

  validates :time_zone, inclusion: {in: ActiveSupport::TimeZone.all.map(&:name)}
  validates_format_of :email, without: TEMP_EMAIL_REGEX, on: :update

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def grouped_stories
    stories.group_by { |g| g.published.to_s(:pretty_day_and_month) }
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)

    # Always add the credentials to the identity
    identity.update_credentials(auth)

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
            password: Devise.friendly_token[0, 20]
        )
        # user.skip_confirmation! TODO:confirmable
        user.save!
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end
end
