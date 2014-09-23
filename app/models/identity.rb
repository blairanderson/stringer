class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider, :token
  validates_uniqueness_of :uid, scope: :provider

  validates_presence_of :secret, if: :twitter?
  validates_presence_of :expires, :expires_at, if: :facebook?

  def self.find_for_oauth(auth)
    find_or_create_by(uid: auth.uid, provider: auth.provider)
  end

  def expires_at=(value)
    super Time.at(value)
  end

  def update_credentials(auth)
    params = ActionController::Parameters.new(auth).require(:credentials)

    creds = params.permit(:token, :secret) if twitter?
    creds = params.permit(:token, :expires, :expires_at) if facebook?

    if creds
      update(creds)
    else
      # TODO: LOG SOMETHING HERE? Should This ever Happen??
      raise("Where Are The Creds?")
    end
  end

  def update(message)
    if twitter?
      client = TwitterService.new(self)
    end

    if facebook?
      client = FacebookService.new(self)
    end

    client.update(message)
  end

  def facebook?
    provider == "facebook"
  end

  def twitter?
    provider == "twitter"
  end
end


