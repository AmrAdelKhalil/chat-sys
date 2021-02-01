class ChatsController < ApplicationController
  before_action :set_application
  before_action :set_chat, except: %i[create]

  def create
    result = ChatServices::Create.call(@application)
    if result.success?
      render json: result.object, status: :created
    else
      render json: errors_msg(result.object), status: :unprocessable_entity
    end
  end

  def update
    result = ChatServices::Update.call(@chat, {})
    if result.success?
      render json: result.object, status: :ok
    else
      render json: errors_msg(result.object), status: :unprocessable_entity
    end
  end

  def show
    render json: @chat, status: :ok
  end

  def search
    render json: MessageServices::Search.call(params[:q],
                                              load: false,
                                              misspellings: {edit_distance: 2},
                                              where: {chat_id: @chat.id},
                                              select: [:chat_id, :body, :message_number]),
           status: :ok
  end

  private

  def set_application
    @application = Application.find_by!(token: senitize_param(params[:application_token]))
  end

  def set_chat
    @chat = Chat.find_by!(application_id: senitize_param(@application.id), chat_number: senitize_param(params[:number]))
  end
end
