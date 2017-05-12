class Api::V1::ProfessorsController < Api::ApiController
  # no CSRF protection for this api
  protect_from_forgery with: :null_session

  before_action  :set_default_response_format, :set_professor, only: [:show, :edit, :update, :destroy]

  # GET /professors
  # GET /professors.json
  def index
    respond Professor.all
  end

  # GET /professors/1
  # GET /professors/1.json
  def show
    respond @professor
  end

  # POST /professors
  # POST /professors.json
  def create
    @professor = Professor.new(professor_params)

    respond_to do |format|
      if @professor.save
        format.json { render json: "Profesor Creado"}
      else
        format.json { render json: @professor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /professors/1
  # PATCH/PUT /professors/1.json
  def update
    respond_to do |format|
      if @professor.update(professor_params)
        format.json { render json: "Profesor Actualizado", status: :ok, location: @professor }
      else
        format.json { render json: @professor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /professors/1
  # DELETE /professors/1.json
  def destroy
    @professor.destroy
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
    def set_professor
      @professor = Professor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def professor_params
      params.require(:professor).permit(:name,:contrato)
    end
end
