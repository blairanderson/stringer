class Messenger

  STUFF = {
      user_id: 2,
      service: "twitter",
      message: {
          'id' =>7,
          'user_id' =>2,
          'content' =>"yolo this is the last"
      }
  }
  def initialize(deps)
    @user_id = deps.user_id
    raise('missing user') unless @user_id
    @service = deps.service
    raise('missing service') unless @service
    @message = deps.message
    raise('missing message') unless @message
  end

  def perform
    user = User.find(@user_id)
    identity = user.identities.where(provider: @service).first
    if identity
      identity.update(@message)
    else
      puts "user: [#{@user_id}] mising identity for service: [#{@service}] Does not exist!"
    end
  end
end