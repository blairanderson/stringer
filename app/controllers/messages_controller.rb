class MessagesController < AccountsController
  before_action :set_message, only: [:edit, :update, :destroy]

  def index
    @messages = current_user.messages
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def create
    @message = current_user.messages.build(message_params)

    if @message.save
      redirect_to messages_path, notice: 'Message was successfully created.'
    else
      render :new
    end
  end

  def update
    if @message.update(message_params)
      redirect_to @message, notice: 'Message was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @message.destroy
    redirect_to messages_url, notice: 'Message was successfully destroyed.'
  end

  private
  def set_message
    @message = current_user.messages.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content, :status)
  end
end
