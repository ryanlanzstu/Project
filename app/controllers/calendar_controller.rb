class CalendarController < ApplicationController
    def month
      @date = Date.parse(params.fetch(:date, Date.today.to_s))
      @tasks = Task.where(start_date: @date.all_month)
    end
  end
  