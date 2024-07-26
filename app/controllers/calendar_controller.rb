class CalendarController < ApplicationController
  def month
    @date = Date.parse(params.fetch(:date, Date.today.to_s))
    @tasks = Task.where(created_at: @date.all_month)
    @events = Event.where(start_time: @date.all_month).group_by { |e| e.start_time.to_date }
  end
end
