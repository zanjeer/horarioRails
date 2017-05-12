class Api::V1::HorariosController < Api::ApiController
  # no CSRF protection for this api
  protect_from_forgery with: :null_session
  before_action  :set_default_response_format, :set_horario, only: [:show, :edit, :update, :destroy]

  # GET /horarios
  # GET /horarios.json
  def index
    @h = Horario.all.map do |h|
      {
        :id => h.id, :horas => h.horas,
        :professor_id => h.professor_id, :name_professor => h.professor.name,
        :curso_id => h.curso_id, :name_curso => h.curso.name,
        :asignatura_id => h.asignatura_id, :name_asignatura => h.asignatura.name
      }
    end
    respond @h
  end

  # GET /horarios/1
  # GET /horarios/1.json
  def show
    respond @horario
  end

  # POST /horarios
  # POST /horarios.json
  def create
    @horario = Horario.new(horario_params)

    respond_to do |format|
      if @horario.save
        format.json { render json: "Horario Creado con exito", status: :created, location: @horario }
      else
        format.json { render json: @horario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /horarios/1
  # PATCH/PUT /horarios/1.json
  def update
    respond_to do |format|
      if @horario.update(horario_params)
        format.json { render json: "Horario Actualizado", status: :ok, location: @horario }
      else
        format.json { render json: @horario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /horarios/1
  # DELETE /horarios/1.json
  def destroy
    @horario.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # respond_whit in house replacement pls
    def respond(response)
      respond_to do |format|
          format.json { render json: response }
        end
    end

    # always respond with json
    def set_default_response_format
      request.format = :json
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_horario
      @horario = Horario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def horario_params
      params.require(:horario).permit(:horas,:curso_id,:professor_id,:asignatura_id)
    end
end
