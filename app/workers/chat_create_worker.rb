require 'sidekiq'
class ChatCreateWorker
  include Sidekiq::Worker

  def perform(args)
    Chat.create!(application_id: args['app_id'], chat_number: args['chat_number'])
  end
end
