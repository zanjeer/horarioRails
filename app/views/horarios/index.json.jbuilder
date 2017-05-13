json.array!(@horarios) do |horario|
  json.extract! horario, :id, :horas
  json.url horario_url(horario, format: :json)
end
