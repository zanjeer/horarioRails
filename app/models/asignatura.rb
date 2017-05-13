class Asignatura < ActiveRecord::Base
  has_many :horarios, :dependent => :destroy

  validates :name, presence: true

  def lectiva?
    if self.lectiva
      @lectiva = "Lectiva"
    else
      @lectiva = "-"
    end
  end
end
