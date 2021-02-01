class MessageCreateWorker
  include Sidekiq::Worker

  def perform(args)
    Message.create!(args)
  end
end
