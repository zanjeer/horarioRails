class CreateAsignaturas < ActiveRecord::Migration
  def change
    create_table :asignaturas do |t|
      t.string :name
      t.boolean :lectiva

      t.timestamps null: false
    end
  end
end
