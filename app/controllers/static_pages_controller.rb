class StaticPagesController < ApplicationController
  def home
    @curso = Curso.new
    @cursos = Curso.all.order('name')

    @professor = Professor.new
    @profes = Professor.all.order('name')

    @asignatura = Asignatura.new
    @asigs = Asignatura.all.order('name')
  end

  def horario
    @cursos = Curso.all.order('name')
  end
end
