class AddContratoToProfessors < ActiveRecord::Migration
  def change
    add_column :professors, :contrato, :integer
  end
end
