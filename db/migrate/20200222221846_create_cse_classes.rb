class CreateCseClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :cse_classes do |t|
      t.string :name
      t.string :section
      t.string :room
      t.string :instructor

      t.timestamps
    end
  end
end
