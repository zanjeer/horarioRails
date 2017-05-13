# json.array! @horarios, partial: 'api/v1/horarios/show', as: :horario
json.partial! partial: 'api/v1/asignaturas/show', collection: @asignaturas, as: :asignatura
