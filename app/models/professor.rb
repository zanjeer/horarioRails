class Professor < ActiveRecord::Base
  has_many :horarios, :dependent => :destroy
  has_many :cursos
  
  validates :name, presence: true

  before_save :default_values
  def default_values
    self.contrato ||= 0
  end
end
