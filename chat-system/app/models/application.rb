class Application < ApplicationRecord
  has_secure_token
  has_many :chats

  def as_json(*)
    super(except: %i[id created_at updated_at])
  end
end
