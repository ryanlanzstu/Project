class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:modules]
  def index
  end

  def modules
    @collegemodules = current_user.collegemodules
  end

  def calendar
    @events = Event.where( #Retrieves events during current calendar month
      start_time: Time.now.beginning_of_month.beginning_of_week.. #Starts calendar from beginning week of the month
      Time.now.end_of_month.end_of_week
    )
  end

end
