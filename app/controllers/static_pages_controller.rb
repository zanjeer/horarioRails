class StaticPagesController < ApplicationController
  def home
    @curso = Curso.new
    @cursos = Curso.all.order('name')

    @professor = Professor.new
    @profes = Professor.all.order('name')

    @asignatura = Asignatura.new
    @asigs = Asignatura.all.order(:orden)

    @prof_selec = Professor.all.order('name').map do |p|
        ["#{p.id}", "#{p.name}"]
    end

  end

  def horario
    @cursos = Curso.all.order('name')
    @profes = Professor.all.order('name')
  end



end
