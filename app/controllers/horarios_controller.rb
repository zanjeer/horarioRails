class HorariosController < ApplicationController

  # se carga la lista de asignaturas asignadas, sin asignar,
  # click en curso
  def lista_asignaturas
    @asignaturas = Asignatura.all
    @id_curso = params[:id]
    @horario = Horario.new
    @horario.curso_id = @id_curso

    respond_to do |format|
      format.js
      format.json
    end
  end

  # se buscan  las asignaturas del curso
  # click en asignatura
  def lista_profes
    @asignaturas = Asignatura.all
    @professors = Professor.all

    @id_asig = params[:id_asig]
    @id_curso = params[:id_curso]

    @horario = Horario.new
    @horario.curso_id = @id_curso
    @horario.asignatura_id = @id_asig

    @horario.save()

  end

  def l_profes_agregados
    @professors = Professor.all

    @id_asig = params[:id_asig]
    @id_curso = params[:id_curso]
    @horario = Horario.find_by(curso_id: @id_curso, asignatura_id: @id_asig)

  end

  # agregar profe + horas
  def agregar_horas
    @professors = Professor.all

    @id_asig = params[:id_asig]
    @id_curso = params[:id_curso]
    @id_profe = params[:id_profe]

    @horario = Horario.find_by(curso_id: @id_curso, asignatura_id: @id_asig)
    @horario.professor_id = @id_profe
    @horario.save
  end

  def quitar_horas
    @professors = Professor.all

    @id_asig = params[:id_asig]
    @id_curso = params[:id_curso]
    @id_profe = params[:id_profe]

    @horario = Horario.find_by(curso_id: @id_curso, asignatura_id: @id_asig, professor_id: @id_profe)
    @horario.professor_id = nil
    @horario.save
  end

  def borrar_asignatura
    @asignaturas = Asignatura.all

    @id_asig = params[:id_asig]
    @id_curso = params[:id_curso]
    @horario = Horario.find_by(curso_id: @id_curso, asignatura_id: @id_asig)
    @horario.destroy
  end

  def horas_ajax
    @id_curso = params[:id_curso]
    @id_asig = params[:id_asig]
    @horas = params[:horas]
    @horario = Horario.find_by(curso_id: @id_curso, asignatura_id: @id_asig)
    @horario.horas = @horas
    @horario.save
  end
  # GET /horarios
  # GET /horarios.json
  def index
    @horarios = Horario.all
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
