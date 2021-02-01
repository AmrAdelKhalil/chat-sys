class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages

  def as_json(option={})
    super(except: %i[id created_at updated_at])
  end
end
