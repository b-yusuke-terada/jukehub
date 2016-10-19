class RoomsController < BaseController
  before_action :set_room, only: [:show]
  def index
    @rooms = @organization.rooms
  end

  def show
  end

  private
  def set_room
    @room = @organization.rooms.find_by({id: params[:id]})
  end
end
