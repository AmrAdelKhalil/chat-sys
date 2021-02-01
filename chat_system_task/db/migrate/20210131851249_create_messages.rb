class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :body
      t.integer :message_number
      t.references :chat, foreign_key: true
      t.index [:chat_id, :message_number], unique: true
      t.timestamps
    end
  end
end
