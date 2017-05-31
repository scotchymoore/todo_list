class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.string :task, null: false
      t.text :description

      t.timestamps
    end
  end
end
