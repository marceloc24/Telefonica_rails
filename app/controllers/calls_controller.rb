class CallsController < ApplicationController
  before_action :set_call, only: %i[ show edit update destroy ]

  # GET /calls or /calls.json
  def index
    @client = Client.find(params[:client_id])
    @calls = @client.calls
  end

  # GET /calls/1 or /calls/1.json
  def show
  end

  # GET /calls/new
  def new
    @client = Client.find(params[:client_id])
    @call = Call.new
    @motives = Motive.all
  end

  # GET /calls/1/edit
  def edit
  end

  # POST /calls or /calls.json
  def create
    @client = Client.find(params[:call][:client_id])
    @call = Call.new(call_params)
    motive_name = params[:call][:motive] # Obtener el nombre del motivo seleccionado

    # Asignar el nombre del motivo directamente al atributo motive de la llamada
    @call.motive = motive_name

    respond_to do |format|
      if @call.save
        format.html { redirect_to client_calls_path(@call), notice: "Call was successfully created." }
        format.json { render :show, status: :created, location: @call }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calls/1 or /calls/1.json
  def update
    respond_to do |format|
      if @call.update(call_params)
        format.html { redirect_to client_calls_path(@call), notice: "Call was successfully updated." }
        format.json { render :show, status: :ok, location: @call }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calls/1 or /calls/1.json
  def destroy
    @call.destroy

    respond_to do |format|
      format.html { redirect_to calls_url, notice: "Call was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_call
      @call = Call.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def call_params
      params.require(:call).permit(:date, :client_id, :user_id).tap do |whitelisted|
        whitelisted[:motive] = params[:call][:motive]
      end
    end
end
