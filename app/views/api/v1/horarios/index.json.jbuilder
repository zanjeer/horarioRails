# json.array! @horarios, partial: 'api/v1/horarios/show', as: :horario
json.partial! partial: 'api/v1/horarios/show', collection: @horarios, as: :horario
