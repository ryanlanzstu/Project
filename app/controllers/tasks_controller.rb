class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[show edit update destroy update_date sort move]

  def index
    @tasks = current_user.tasks
  end
  def sort
    if @task.update(row_order_position: params[:row_order_position], list_id: params[:list_id])
      head :no_content  # No content to send back on successful update
    else
      render json: @task.errors.full_messages, status: :unprocessable_entity
    end
  end
  def update_date
    if @task.update(start_date: params[:date])
      render json: { status: 'success' }, status: :ok
    else
      render json: @task.errors.full_messages, status: :unprocessable_entity
    end
  end

  def move
    if @task.update(task_params)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def show
  end

  def new
    @task = current_user.tasks.build
  end
  def edit
  end
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to task_url(@task), notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end
  def update
    if @task.update(task_params)
      redirect_to task_url(@task), notice: "Task was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "Task was successfully destroyed."
  end
  private
  def set_task
    @task = current_user.tasks.find(params[:id])
  end
  def task_params
    params.require(:task).permit(:name, :list_id, :start_date, :end_date, :description)
  end
end