class CollegemodulesController < ApplicationController
  before_action :set_collegemodule, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /collegemodules or /collegemodules.json
  def index
    @collegemodules = current_user.collegemodules
  end

  # GET /collegemodules/1 or /collegemodules/1.json
  def show
  end

  # GET /collegemodules/new
  def new
    @collegemodule = current_user.collegemodules.build
  end

  # GET /collegemodules/1/edit
  def edit
  end

  # POST /collegemodules or /collegemodules.json
  def create
    @collegemodule = current_user.collegemodules.build(collegemodule_params)

    respond_to do |format|
      if @collegemodule.save
        format.html { redirect_to collegemodule_url(@collegemodule), notice: "Module Created!" }
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
        format.html { redirect_to collegemodule_url(@collegemodule), notice: "Module Updated!" }
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
      format.html { redirect_to collegemodules_url, notice: "Module Deleted!" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collegemodule
      @collegemodule = current_user.collegemodules.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def collegemodule_params
      params.require(:collegemodule).permit(:module_name, :module_id, :module_lecturer)
    end
end
