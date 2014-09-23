class TwitterService
  def initialize(auth)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key         = ENV["TWITTER_API_KEY"]
      config.consumer_secret      = ENV["TWITTER_API_SECRET"]
      config.access_token         = auth.token
      config.access_token_secret  = auth.secret
    end
  end

  def update(message)
    if message
      @client.update(message)
    end
  end
end