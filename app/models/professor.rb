class Professor < ActiveRecord::Base
  has_many :horarios, :dependent => :destroy


  validates :name, presence: true
end
