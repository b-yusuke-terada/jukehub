class RoomsController < BaseController
  before_action :set_room, only: [:show]
  def index
    @rooms = Room.all
  end

  def show
  end

  def new
    @room = Room.new
  end

  def create
    room = Room.create(room_params)
    redirect_to room
  end

  private
  def set_room
    @room = Room.find_by({name: params[:name]})
  end

  def room_params
    params.require(:room).permit(:screen_name)
  end
end
