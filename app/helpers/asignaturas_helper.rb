module AsignaturasHelper
  def esta_asignada(asignatura)
    @asig_asignadas = Horario.where('curso_id = ? AND asignatura_id = ?', @horario.curso_id, asignatura)
    @asig_asignadas.any?
  end
end
