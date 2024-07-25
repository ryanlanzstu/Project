class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_list, only: %i[new create]

  # GET /tasks or /tasks.json
  def index
    @tasks = current_user.tasks
  end

  # Use same as lists for time being to sort tasks, can't do it within different lists
  def sort
    @task = current_user.tasks.find(params[:id])
    @task.update(row_order_position: params[:row_order_position], list_id: params[:list_id])
    head :no_content
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.build
    @task.list_id = @list.id if @list
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = current_user.tasks.build(task_params)
    @task.list_id = @list.id if @list

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task.list ? list_path(@task.list) : task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id]) if params[:list_id]
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:name, :list_id, :start_date, :end_date, :description)
  end
end
