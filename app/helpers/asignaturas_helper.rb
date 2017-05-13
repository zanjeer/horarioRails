module AsignaturasHelper
  def esta_asignada(asignatura)
    @asig_asignadas = Horario.where('curso_id = ? AND asignatura_id = ?', @horario.curso_id, asignatura)
    @asig_asignadas.any?
  end

  def esta_asig(asignatura)
    @asig_asignadas = Horario.where('professor_id = ? AND asignatura_id = ?', @horario.professor_id, asignatura)
    @asig_asignadas.any?
  end
end
