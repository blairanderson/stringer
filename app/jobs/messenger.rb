class Messenger
  def initialize(deps)
    @user = deps.user
    raise('missing user') if @user.nil?
    @service = deps.service
    raise('missing service') if @service.nil?
    @message = deps.message
    raise('missing message') if @message.nil?
  end

  def perform
    service = @user.services.where(name: @service).first

    if service
      service.client.update(message)
    end

  end
end