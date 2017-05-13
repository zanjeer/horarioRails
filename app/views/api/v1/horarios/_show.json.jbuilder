json.(horario, :id, :horas)
json.edit_url edit_horario_url(horario)

json.curso do |json|
  json.(horario.curso, :name)
  json.url curso_url(horario.curso)
end

json.professor do |json|
  json.(horario.professor, :name)
  json.url professor_url(horario.professor)
end

json.asignatura do |json|
  json.(horario.asignatura, :name)
  json.url asignatura_url(horario.asignatura)
end
