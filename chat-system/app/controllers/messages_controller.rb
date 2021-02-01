class MessagesController < ApplicationController
  before_action :set_application
  before_action :set_chat
  before_action :set_message, except: %i[create]

  def create
    result = MessageServices::Create.call(@application, @chat, message_params)
    if result.success?
      render json: result.object, status: :created
    else
      render json: errors_msg(result.object), status: :unprocessable_entity
    end
  end

  def update
    result = MessageServices::Update.call(@message, message_params)
    if result.success?
      render json: result.object, status: :ok
    else
      render json: errors_msg(result.object), status: :unprocessable_entity
    end
  end

  def show
    render json: @message, status: :ok
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def set_application
    @application = Application.find_by!(token: senitize_param(params[:application_token]))
  end

  def set_chat
    @chat = Chat.find_by!(application_id: @application.id, chat_number: senitize_param(params[:chat_number]))
  end

  def set_message
    @message = Message.find_by!(chat_id:@chat.id, message_number: senitize_param(params[:number]))
  end
end
