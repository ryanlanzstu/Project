class CalendarController < ApplicationController
  def month
    @date = Date.parse(params.fetch(:date, Date.today.to_s))
    @tasks = Task.where(start_date: @date.all_month)
  end

  def update_task_date
    @task = Task.find(params[:id])
    @task.update(start_date: params[:start_date])
    head :ok
  end
end
