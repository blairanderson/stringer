class MessagesController < ApplicationController
  before_action :set_message, only: [:edit, :update, :destroy]

  def index
    @messages = current_user.messages
  end

  def new
    @message = Message.new(content: "Here is an example tweet! http://type-a-url-and-it-becomes-a-link.com - delete me and get started")
    render layout: "message_form", template: "messages/edit"
  end

  def edit
    render layout: "message_form", template: "messages/edit"
  end

  def create
    @message = current_user.messages.build(message_params)

    if @message.save
      redirect_to messages_path, notice: t('message.create.success')
    else
      render :new
    end
  end

  def update
    if @message.update(message_params)
      redirect_to messages_path, notice: t('message.update.success')
    else
      render :edit
    end
  end

  def destroy
    @message.destroy
    redirect_to messages_url, notice: t('message.destroy.success')
  end

  private
  def set_message
    @message = current_user.messages.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content, :status)
  end
end
