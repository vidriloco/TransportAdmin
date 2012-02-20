class StationsController < ActionController::Base
  layout 'application' 
    
  before_filter :find_line, :except => [:destroy, :edit]
  
  def new
    @station = Station.new
  end
  
  def create
    @station = Station.new(params[:station])
    @station.apply_geo(params[:coordinates])
    
    if @station.save
      
      redirect_to @line, :notice => I18n.t('stations.create.messages.saved')
    else
      render :action => "new"
    end
  end
  
  def destroy
    @station = Station.find(params[:id])
    @station.destroy
    
    redirect_to @station.line, :notice => I18n.t('stations.destroy.messages.done')
  end
  
  def edit
    @station = Station.find(params[:id])
    @line = @station.line
  end
  
  def update
    @station = Station.find(params[:id])
    @station.apply_geo(params[:coordinates])
    
    if @station.update_attributes(params[:station])
      redirect_to @line, :notice => I18n.t('stations.update.messages.saved')
    else
      render :action => "edit"
    end
  end
  
  private 
  def find_line
    @line= params.has_key?(:station) ? Line.find(params[:station][:line_id]) : Line.find(params[:line_id])
  end
end