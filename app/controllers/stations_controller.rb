class StationsController < ActionController::Base
  layout 'application' 
    
  before_filter :build_agrouper
  
  def new
    @station = Station.new
  end
  
  def create
    @station = Station.new(params[:station])
    @station.apply_geo(params[:coordinates])
    
    if @station.save
      
      redirect_to @station.agrouper, :notice => I18n.t('stations.create.messages.saved')
    else
      render :action => "new"
    end
  end
  
  def destroy
    @station = Station.find(params[:id])
    agrouper = @station.agrouper
    @station.destroy
    
    redirect_to agrouper, :notice => I18n.t('stations.destroy.messages.done')
  end
  
  def edit
    @station = Station.find(params[:id])
    @agrouper = @station.agrouper
  end
  
  def update
    @station = Station.find(params[:id])
    @station.apply_geo(params[:coordinates])
    
    if @station.update_attributes(params[:station])
      redirect_to @station.agrouper, :notice => I18n.t('stations.update.messages.saved')
    else
      render :action => "edit"
    end
  end
  
  private 
  def build_agrouper
    parameters = action_name.eql?("create") || action_name.eql?("update") ? params[:station] : params
    if parameters[:agrouper_type].eql?("Line") 
      @agrouper=Line.find(parameters[:agrouper_id])
    elsif parameters[:agrouper_type].eql?("Partition")
      @agrouper=Partition.find(parameters[:agrouper_id])
    end
  end
end