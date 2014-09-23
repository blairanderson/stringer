class TwitterService
  def initialize(auth)
    @token = auth.token
    @secret = auth.secret
  end

  def update(message)
    TwitterClient.new()
  end
end