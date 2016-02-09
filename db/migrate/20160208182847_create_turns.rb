class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.date :at
      t.belongs_to :employee, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_column :visits, :turn_id, :integer, index: true
  end
end
