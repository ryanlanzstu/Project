class CalendarController < ApplicationController
  def month
    @date = Date.parse(params.fetch(:date, Date.today.to_s))
    @tasks = Task.where(created_at: @date.beginning_of_month..@date.end_of_month)
  end
end
