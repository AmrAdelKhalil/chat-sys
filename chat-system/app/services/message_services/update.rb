module MessageServices
  class Update < ServicesBase
    def self.call(message, message_params={})
      if message.update(message_params)
        Result.new(object: message, success: true)
      else
        Result.new(object: message, success: false)
      end
    end
  end
end