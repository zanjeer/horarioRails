class AddUserRefToHorarios < ActiveRecord::Migration
  def change
    add_reference :horarios, :curso, index: true, foreign_key: true
  end

end
