module ChatServices
  class Update < ServicesBase
    def self.call(chat, chat_params={})
      if chat.update(chat_params)
        Result.new(object: chat, success: true)
      else
        Result.new(object: chat, success: false)
      end
    end
  end
end