FactoryBot.define do
  factory :application do
    desc {Faker::Lorem.paragraph}
    sequence(:token) {|n| "token_#{n}"}
    chats_count {0}

    factory :application_with_chats do
      transient do
        chats {[]}
      end

      after(:create) do |app, evaluator|
        app.chats << evaluator.chats
      end
    end
  end
end