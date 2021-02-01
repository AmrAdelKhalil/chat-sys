class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :desc
      t.string :token, index: true
      t.integer :chats_count, default: 0
      t.index [:id, :token]
      t.timestamps
    end
  end
end
