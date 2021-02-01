require 'sidekiq-scheduler'

class ChatCounterUpdaterWorker
  include Sidekiq::Worker

  def perform(*args)
    chat_by_application_id = Chat.group(:application_id).count
    chat_by_application_id = chat_by_application_id.safe_invert
    chat_by_application_id.each do |value, ids|
      Application.where(id: ids).update(chats_count: value)
    end
  end
end
