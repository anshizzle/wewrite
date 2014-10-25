class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :text
      t.integer :score
      t.integer :depth
      t.integer :previous_line

      t.timestamps
    end
  end
end
