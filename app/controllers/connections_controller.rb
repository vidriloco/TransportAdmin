class ConnectionsController < ActionController::Base
  
  layout 'application'
  
  def new
    @line = Line.find(params[:line_id])
    @connection = Connection.new
  end
  
  def create
    @connection = Connection.new(params[:connection])
    @line = @connection.one_line
    
    if @connection.save
      redirect_to(@line, :notice => I18n.t('connections.create.messages.saved'))
    else
      render :action => :new
    end
  end
  
  def destroy
    @connection = Connection.find(params[:id])
    @connection.destroy
    
    redirect_to(@connection.one_line, :notice =>  I18n.t('connections.destroy.messages.done'))
  end
  
  def edit
    @connection = Connection.find(params[:id])
    @line = Line.find(params[:line_id])
  end
  
  def update
    @connection = Connection.find(params[:id])
    @line = Line.find(params[:connection][:one_line_id])
    
    if @connection.update_attributes(params[:connection])
      redirect_to(@line, :notice => I18n.t('connections.update.messages.saved'))
    else
      render :action => :edit
    end
  end
  
end
