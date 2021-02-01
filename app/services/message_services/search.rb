module MessageServices
  class Search < ServicesBase
    def self.call(query, options={})
      Message.search(query, options).results.map do |result|
        {
          body: result['body'],
          chat_id: result['chat_id'],
          message_number: result['message_number']
        }
      end
    end
  end
end