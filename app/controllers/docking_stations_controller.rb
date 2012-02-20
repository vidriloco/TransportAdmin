class DockingStationsController < ActionController::Base
  layout 'application'
  
  def new
    @transport = Transport.find(params[:transport_id])
    @docking_station = DockingStation.new
  end
  
  def create
    @docking_station = DockingStation.new(params[:docking_station])
    @docking_station.apply_geo(params[:coordinates])
    
    if @docking_station.save
      
      redirect_to @docking_station.transport, :notice => I18n.t('docking_stations.create.messages.saved')
    else
      render :action => "new"
    end
  end
  
  def destroy
    @docking_station = DockingStation.find(params[:id])
    @docking_station.destroy
    
    redirect_to(@docking_station.transport, :notice => I18n.t('docking_stations.destroy.messages.done'))
  end
  
end