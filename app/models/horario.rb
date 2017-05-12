# en caso que el horario no tenga aluna relacion asignada
# se creara un modelo de la relacion NULL para que lo remplace
#  y no se caiga el api, query, etc

class NullCurso
  def name
    'no asignado'
  end
end

class NullAsignatura
  def name
    'no asignada'
  end
end

class NullProfessor
  def name
    'no tiene'
  end
end

class Horario < ActiveRecord::Base
  belongs_to :asignatura
  belongs_to :professor
  belongs_to :curso
  delegate :name, to: :curso, prefix: :curso
  delegate :name, to: :professor, prefix: :professor
  delegate :name, to: :asignatura, prefix: :asignatura

  before_save :default_values
  def default_values
    self.horas ||= 5
  end

  def curso
    super || NullCurso.new
  end

  def professor
    super || NullProfessor.new
  end

  def asignatura
    super || NullAsignatura.new
  end
end
