class FacebookService
  def initialize(auth)
    #TODO if auth.expires => true
    #if auth.expires_at is in the past
    #attempt to renew it and continue
    @client = FbGraph::User.me(auth.token)
  end

  def update(message)
    if message
      @client.feed!(message: message)
      # TODO: link: 'https://github.com/nov/fb_graph'
      # TODO: name: 'FbGraph'
      # TODO: picture: 'https://graph.facebook.com/matake/picture'
      # TODO: description: 'A Ruby wrapper for Facebook Graph API'
    end
  end
end


