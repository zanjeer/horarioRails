class Horario < ActiveRecord::Base
  belongs_to :asignatura
  belongs_to :professor
  belongs_to :curso

  before_save :default_values
  def default_values
    self.horas ||= 5
  end
end
