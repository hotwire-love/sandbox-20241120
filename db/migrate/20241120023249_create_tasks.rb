class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.boolean :done, default: false, null: false

      t.timestamps
    end
  end
end
