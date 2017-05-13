module ProfessorsHelper
  def esta_asignado(profe, asignatura)
    @profe = Horario.where('curso_id = ? AND asignatura_id = ? AND professor_id = ?',
                                    @horario.curso_id, asignatura, profe)
    @profe.any?
  end

end
