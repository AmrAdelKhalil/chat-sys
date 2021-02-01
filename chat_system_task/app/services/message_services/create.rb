module MessageServices
  class Create < ServicesBase
    def self.call(app, chat, message_params)
      Chat.find(chat.id).with_lock do
        max_number = Message.where(chat_id: chat.id).maximum(:message_number) || 0
        MessageCreateWorker.perform_async(message_params.to_h.merge('chat_id' => chat.id, 'message_number' => max_number + 1))
        Result.new(object: {message_number: max_number + 1}, success: true)
      end
    end
  end
end