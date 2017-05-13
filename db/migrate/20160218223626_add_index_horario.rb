class AddIndexHorario < ActiveRecord::Migration
  def change
    add_index "horarios", ["asignatura_id", "curso_id"], name: "index_horarios_on_asignatura_id_and_curso_id", unique: true, using: :btree
  end
end
