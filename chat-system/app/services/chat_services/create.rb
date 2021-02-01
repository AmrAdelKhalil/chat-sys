module ChatServices
  class Create < ServicesBase
    def self.call(app)
      Sidekiq.redis do |connection|
        lock = RedisLock.new(app.token, redis: connection)
        mx_chat_number = lock.value

        mx_chat_number = mx_chat_number.nil? ? Chat.where(application_id: app.id).count : mx_chat_number.to_i

        ChatCreateWorker.perform_async({'app_id' => app.id, 'chat_number' => mx_chat_number + 1})
        lock.set(60, {value: (mx_chat_number + 1).to_s})
        Result.new(object: {chat_number: mx_chat_number + 1}, success: true)
      end
    end
  end
end