class Api::V1::AsignaturasController < Api::ApiController
  # no CSRF protection for this api
  protect_from_forgery with: :null_session

  before_action  :set_default_response_format,:set_asignatura, only: [:show, :edit, :update, :destroy]

  # GET /asignaturas
  # GET /asignaturas.json
  def index
    respond Asignatura.all
  end

  # GET /asignaturas/1
  # GET /asignaturas/1.json
  def show
    respond @asignatura
  end

  # POST /asignaturas
  # POST /asignaturas.json
  def create
    @asignatura = Asignatura.new(asignatura_params)

    respond_to do |format|
      if @asignatura.save
        format.json { render json: "Asignatura Creada", status: :created, location: @asignatura }
      else
        format.json { render json: @asignatura.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asignaturas/1
  # PATCH/PUT /asignaturas/1.json
  def update
    respond_to do |format|
      if @asignatura.update(asignatura_params)
        format.json { render json: "Asinatura Actualizada", status: :ok, location: @asignatura }
      else
        format.json { render json: @asignatura.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asignaturas/1
  # DELETE /asignaturas/1.json
  def destroy
    @asignatura.destroy
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
    def set_asignatura
      @asignatura = Asignatura.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asignatura_params
      params.require(:asignatura).permit(:name, :lectiva, :orden)
    end
end
