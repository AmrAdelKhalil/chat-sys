FactoryBot.define do
  factory :message do
    sequence(:message_number) {|n| n}
    body {Faker::Lorem.paragraph}
  end
end