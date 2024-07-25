class CalendarController < ApplicationController
  def month
    @date = Date.parse(params.fetch(:date, Date.today.to_s))
    @tasks = Task.where(created_at: @date.beginning_of_month..@date.end_of_month)
  end

  def update_task_date
    @task = Task.find(params[:id])
    @task.update(created_at: params[:date])
    head :no_content
  end
end
