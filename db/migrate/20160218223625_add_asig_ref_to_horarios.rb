class AddAsigRefToHorarios < ActiveRecord::Migration
  def change
    add_reference :horarios, :asignatura, index: true, foreign_key: true
  end
end
