class MessageBuilder < Struct.new(:user_id)
  def perform
    user = User.find(user_id)
    message = user.messages.first

    if message
      Service::LIST.each do |service|
        Messenger.new({user: user, service: service, message: message})
      end
    end
  end
end