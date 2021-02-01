require 'sidekiq-scheduler'

class MessageReindexWorker
  include Sidekiq::Worker

  def perform(*args)
    Message.reindex
  end
end
