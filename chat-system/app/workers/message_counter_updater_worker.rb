require 'sidekiq-scheduler'

class MessageCounterUpdaterWorker
  include Sidekiq::Worker

  def perform(*args)
    message_by_chat_id = Message.group(:chat_id).count
    message_by_chat_id = message_by_chat_id.safe_invert
    message_by_chat_id.each do |value, ids|
      Chat.where(id: ids).update(messages_count: value)
    end
  end
end
