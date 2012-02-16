class StationsController < ActionController::Base
  def new
    @agrouper = Line.find(params[:agrouper_id])
    
    @station = Station.new
  end
end