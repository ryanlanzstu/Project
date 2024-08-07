class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: %i[ show edit update destroy ]
  # GET /events or /events.json
  def index
    @events = Event.all
    @lists = List.includes(:tasks).where(user: current_user)
  end

  # GET /events/1 or /events/1.json
  def show
    @lists = List.includes(:tasks).where(user: current_user)
  end

  # GET /events/new
  def new
    @event = Event.new
  end
  # GET /events/1/edit
  def edit
  end
  # POST /events or /events.json
  def create
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event deleted." }
      format.json { head :no_content }
    end
  end
  private
    #Callback for setup constraints
    def set_event
      @event = Event.find(params[:id])
    end
    #Only works for trusted params
    def event_params
      params.require(:event).permit(:title, :description, :start_time, :end_time)
    end
end