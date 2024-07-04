class CollegemodulesController < ApplicationController
  before_action :set_collegemodule, only: %i[ show edit update destroy ]

  # GET /collegemodules or /collegemodules.json
  def index
    @collegemodules = Collegemodule.all
  end

  # GET /collegemodules/1 or /collegemodules/1.json
  def show
  end

  # GET /collegemodules/new
  def new
    @collegemodule = Collegemodule.new
  end

  # GET /collegemodules/1/edit
  def edit
  end

  # POST /collegemodules or /collegemodules.json
  def create
    @collegemodule = Collegemodule.new(collegemodule_params)

    respond_to do |format|
      if @collegemodule.save
        format.html { redirect_to collegemodule_url(@collegemodule), notice: "Collegemodule was successfully created." }
        format.json { render :show, status: :created, location: @collegemodule }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @collegemodule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collegemodules/1 or /collegemodules/1.json
  def update
    respond_to do |format|
      if @collegemodule.update(collegemodule_params)
        format.html { redirect_to collegemodule_url(@collegemodule), notice: "Collegemodule was successfully updated." }
        format.json { render :show, status: :ok, location: @collegemodule }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @collegemodule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collegemodules/1 or /collegemodules/1.json
  def destroy
    @collegemodule.destroy

    respond_to do |format|
      format.html { redirect_to collegemodules_url, notice: "Collegemodule was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collegemodule
      @collegemodule = Collegemodule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def collegemodule_params
      params.fetch(:collegemodule, {})
    end
end
