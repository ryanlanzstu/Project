class CalendarController < ApplicationController
    def month
        @date = Date.parse(params.fetch(:date, Date.today.to_s))
    end
end
