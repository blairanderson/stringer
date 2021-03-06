class Messenger
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
      identity.compose_message(@message)
    else
      raise "user: [#{@user_id}] missing identity for service: [#{@service}] Does not exist!"
    end
  end
end