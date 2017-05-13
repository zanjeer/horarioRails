class Api::V1::CursosController < Api::ApiController
	# no CSRF protection for this api
	protect_from_forgery with: :null_session

  before_action :set_default_response_format, :set_curso, only: [:show, :edit, :update, :destroy]

  # GET /cursos
  # GET /cursos.json
  def index
     @cursos = Curso.all
  end

  # GET /cursos/1
  # GET /cursos/1.json
  def show
  end

  # POST /cursos
  # POST /cursos.json
  def create
    @curso = Curso.new(curso_params)

    respond_to do |format|
      if @curso.save
        format.json { render json: "Curso Creado", status: :created }
      else
        format.json { render json: @curso.errors}
      end
    end
  end

  # PATCH/PUT /cursos/1
  # PATCH/PUT /cursos/1.json
  def update
    respond_to do |format|
      if @curso.update(curso_params)
        format.json { render json: "Curso Actualizado", status: :ok, location: @curso }
      else
        format.json { render json: @curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cursos/1
  # DELETE /cursos/1.json
  def destroy
    @curso.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
		# always respond with json
  	def set_default_response_format
		  request.format = :json
		end

    # Use callbacks to share common setup or constraints between actions.
    def set_curso
      @curso = Curso.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def curso_params
      params.require(:curso).permit(:name, :professor_id)
    end
end
