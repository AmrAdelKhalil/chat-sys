FactoryBot.define do
  factory :chat do
    sequence(:chat_number) {|n| n}
    messages_count {0}

    factory :chat_with_messages do
      transient do
        messages {[]}
      end

      after(:build) do |chat, evaluator|
        chat.messages = evaluator.messages
      end
    end
  end
end