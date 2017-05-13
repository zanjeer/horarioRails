class ReferenciaProfeJefe < ActiveRecord::Migration
  def change
    add_reference :cursos, :professor, index: true, foreign_key: true
  end
end
