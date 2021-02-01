module ChatServices
  class Create < ServicesBase
    def self.call(app)
      Application.find(app.id).with_lock do
        max_number = Chat.where(application_id: app.id).maximum(:chat_number) || 0
        ChatCreateWorker.perform_async({'app_id' => app.id, 'chat_number' => max_number + 1})
        Result.new(object: {chat_number: max_number + 1}, success: true)
      end
    end
  end
end