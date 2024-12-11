class CreateSections < ActiveRecord::Migration[7.1]
  def change
    create_table :sections do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.references :classroom, null: false, foreign_key: true
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.string :days, null: false # e.g., "MWF", "TTh", "MTWThF"
      
      t.timestamps
    end
  end
end
