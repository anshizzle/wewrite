class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.boolean :opened
      t.integer :line_id

      t.timestamps
    end
  end
end
