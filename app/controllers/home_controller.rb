class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:modules]
  def index
  end

  def modules
    @collegemodules = current_user.collegemodules
  end

  def calendar
    @events = Event.where(
      start_time: Time.now.beginning_of_month.beginning_of_week..
      Time.now.end_of_month.end_of_week
    )
  end

end
