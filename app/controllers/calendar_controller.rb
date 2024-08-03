class CalendarController < ApplicationController
  def month
    @date = Date.parse(params.fetch(:date, Date.today.to_s))
    @tasks = Task.where("start_date >= ? AND start_date <= ?", @date.beginning_of_month, @date.end_of_month)
    @events = Event.where(start_time: @date.all_month).group_by { |e| e.start_time.to_date }
    @lists = List.includes(:tasks).where(user: current_user) # Fetches list for current user only
  end
end