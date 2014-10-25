class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :text
      t.integer :score
      t.integer :depth
      t.integer :previous_line_id

      t.timestamps
    end
  end
end
