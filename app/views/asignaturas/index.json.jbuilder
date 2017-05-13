json.array!(@asignaturas) do |asignatura|
  json.extract! asignatura, :id, :name, :lectiva
  json.url asignatura_url(asignatura, format: :json)
end
