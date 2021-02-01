class Message < ApplicationRecord
  searchkick
  belongs_to :chat
  validates :body, presence: true
end
