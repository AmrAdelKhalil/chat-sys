# Application(id: integer, desc: string, token: string, chats_count: integer)
# Chat(id: integer, messages_count: integer, chat_number: integer, application_id: integer)
# Message(id: integer, body: string, message_number: integer, chat_id: integer)

apps = []

5.times {
  apps << Application.create!(desc: Faker::Lorem.paragraph)
}

chats = []
apps.each do |app|
  (1..3).each do |n|
    app.chats << Chat.create(chat_number: n)
  end
  chats << app.chats
end

chats = chats.flatten

chats.each do |chat|
  (1..3).each do |n|
    chat.messages << Message.create(body: Faker::Lorem.paragraph, message_number: n)
  end
end
