class ChangeHorasFormatInHorarios < ActiveRecord::Migration
  def self.up
   change_column :horarios, :horas, :decimal
 end

 def self.down
   change_column :horarios, :horas, :integer
 end
end
