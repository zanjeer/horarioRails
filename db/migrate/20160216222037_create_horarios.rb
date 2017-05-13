class CreateHorarios < ActiveRecord::Migration
  def change
    create_table :horarios do |t|
      t.integer :horas
    
      t.references :professor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
