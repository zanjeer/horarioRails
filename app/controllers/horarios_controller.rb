class HorariosController < ApplicationController

  def informe
    # @profes = Professor.all.order('name')
    @profes_jefes = Professor.all.joins(:cursos).order('cursos.name')
    @profes = Professor.all.where.not(id: Curso.select(:professor_id)).order('name')
    respond_to do |format|
      format.pdf do
        pdf = HorarioPdf.new(@profes, @profes_jefes)
        send_data pdf.render, filename: "horario",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  # lista asignaturas no lectivas
  # asignar asignatura
  # los profesores tienen horas no lectivas
  def horas_no_lec
    @asignaturas = Asignatura.where('lectiva=false').order('orden')
    @lectiva = false
    @id_asig = params[:id_asig]
    @id_profe = params[:id_profe]
    @horario = Horario.new
    @horario.professor_id = @id_profe
    @horario.asignatura_id = @id_asig
    @horario.save()

  end

  # lista asignaturas lectivas de un profesor
  #
  def horas_no_lec_agre
    @asignaturas = Asignatura.where('lectiva=false').order('orden')
    @lectiva = false
    @id_asig = params[:id_asig]
    @id_profe = params[:id_profe]
    @horario = Horario.find_by(professor_id: @id_profe, asignatura_id: @id_asig)

    respond_to do |format|
      format.js
      format.json
    end
  end

  # lista asignaturas lectivas al hacer click en lista de cursos
  # se crea un horario base
  def lista_asignaturas
    @asignaturas = Asignatura.all.order('orden').where('lectiva=true')
    @id_curso = params[:id]
    @horario = Horario.new
    @horario.curso_id = @id_curso
    @lectiva = true

    respond_to do |format|
      format.js
      format.json
    end
  end

  # lista asignaturas no lectivas
  # horario base
  def lista_asig_no_lectivas
    @asignaturas = Asignatura.all.order('orden').where('lectiva=false')
    @id_profe = params[:id]
    @horario = Horario.new
    @horario.professor_id = @id_profe
    @lectiva = false

    respond_to do |format|
      format.js
      format.json
    end
  end

  # lista de profesores al hacer click en una asignatura
  # curso + asig + profe
  def lista_profes
    @asignaturas = Asignatura.where('lectiva=true').order('orden')
    @professors = Professor.all.order('name')
    @lectiva = true
    @id_asig = params[:id_asig]
    @id_curso = params[:id_curso]

    @horario = Horario.new
    @horario.curso_id = @id_curso
    @horario.asignatura_id = @id_asig

    @horario.save()

  end

  # lista profesores agregados a un curso y asignatura
  def l_profes_agregados
    @professors = Professor.all.order('name')

    @id_asig = params[:id_asig]
    @id_curso = params[:id_curso]
    @horario = Horario.find_by(curso_id: @id_curso, asignatura_id: @id_asig)

  end

  # agregar profe + horas
  # lista profes al hacer click en una asignautra
  def agregar_horas
    @professors = Professor.all.order('name')

    @id_asig = params[:id_asig]
    @id_curso = params[:id_curso]
    @id_profe = params[:id_profe]

    @horario = Horario.find_by(curso_id: @id_curso, asignatura_id: @id_asig)
    @horario.professor_id = @id_profe
    @horario.save
  end

  # lista profesores de un curso y asignatura
  # quita al profesor seleccionado
  def quitar_horas
    @professors = Professor.all.order('name')

    @id_asig = params[:id_asig]
    @id_curso = params[:id_curso]
    @id_profe = params[:id_profe]

    @horario = Horario.find_by(curso_id: @id_curso, asignatura_id: @id_asig, professor_id: @id_profe)
    @horario.professor_id = nil
    @horario.save
  end

  # lista asignaturas lectivas
  # se borra la asignatura por lo que se borra el horario
  def borrar_asignatura
    @asignaturas = Asignatura.where('lectiva=true').order('orden')
    @lectiva = true
    @id_asig = params[:id_asig]
    @id_curso = params[:id_curso]
    @horario = Horario.find_by(curso_id: @id_curso, asignatura_id: @id_asig)
    @horario.destroy
  end

  # lista asignaturas no lectivas
  # se quita asignatura el horario se borra
  def borrar_asignatura_no_lec
    @asignaturas = Asignatura.where('lectiva=false').order('orden')
    @lectiva = false
    @id_asig = params[:id_asig]
    @id_profe = params[:id_profe]
    @horario = Horario.find_by(professor_id: @id_profe, asignatura_id: @id_asig)
    @horario.destroy
  end

  # actualiza las horas de un horario especifico
  def horas_ajax
    @id = params[:id_horario]
    @horas = params[:horas]
    @horario = Horario.find_by(id: @id)
    @horario.horas = @horas
    @horario.save
  end
  
  # GET /horarios
  # GET /horarios.json
  def index
    @horarios = Horario.all.order('name')
  end

  # GET /horarios/1
  # GET /horarios/1.json
  def show
  end

  # GET /horarios/new
  def new
    @horario = Horario.new
  end

  # GET /horarios/1/edit
  def edit
  end

  # POST /horarios
  # POST /horarios.json
  def create
    @horario = Horario.new(horario_params)

    respond_to do |format|
      if @horario.save
        format.html { redirect_to @horario, notice: 'Horario was successfully created.' }
        format.json { render :show, status: :created, location: @horario }
        format.js
      else
        format.html { render :new }
        format.json { render json: @horario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /horarios/1
  # PATCH/PUT /horarios/1.json
  def update
    respond_to do |format|
      if @horario.update(horario_params)
        format.html { redirect_to @horario, notice: 'Horario was successfully updated.' }
        format.json { render :show, status: :ok, location: @horario }
      else
        format.html { render :edit }
        format.json { render json: @horario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /horarios/1
  # DELETE /horarios/1.json
  def destroy
    @horario.destroy
    respond_to do |format|
      format.html { redirect_to horarios_url, notice: 'Horario was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_horario
      @horario = Horario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def horario_params
      params.require(:horario).permit(:hora)
    end


end
