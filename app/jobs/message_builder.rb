class MessageBuilder
  def initialize(user)
    @user = user
    raise("BOOM") unless @user
  end

  def perform
    # Grab the most recent message, delete it from th
    message = @user.messages.first

    if message
      message_details = message.delete.attributes
      Service::LIST.each do |service|
        message = Messenger.new({
                                    user_id: user.id,
                                    service: service,
                                    message: message_details
                                })
        Delayed::Job.enqueue(message)
      end
    end
  end
end




