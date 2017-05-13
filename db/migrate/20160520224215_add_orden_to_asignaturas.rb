class AddOrdenToAsignaturas < ActiveRecord::Migration
  def change
    add_column :asignaturas, :orden, :integer
  end
end
