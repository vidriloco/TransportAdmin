class VehiclesController < ActionController::Base
  layout 'application'
  
  def new
    @vehicle = Vehicle.new
  end
  
  def create
    @vehicle = Vehicle.new(params[:vehicle])
    
    if @vehicle.save
      redirect_to(vehicles_url, :notice => I18n.t('vehicles.create.messages.saved'))
    else
      render :action => :new
    end
  end
  
  def index
    @vehicles = Vehicle.all
  end
  
  def edit
    @vehicle = Vehicle.find(params[:id])
  end
  
  def update
    @vehicle = Vehicle.find(params[:id])
    
    if @vehicle.update_attributes(params[:vehicle])
      redirect_to(vehicles_url, :notice => I18n.t('vehicles.update.messages.saved'))
    else
      render :action => :edit
    end
  end
  
  def destroy
    @vehicle = Vehicle.find(params[:id])
    @vehicle.destroy
    
    redirect_to(vehicles_url, :notice => I18n.t('vehicles.destroy.messages.done'))
  end
end