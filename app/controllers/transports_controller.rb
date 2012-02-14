class TransportsController < ActionController::Base
  
  layout 'application'
  
  before_filter :find_transport, :only => [:show, :edit, :update]
  
  def new
    @transport = Transport.new
  end
  
  def create
    @transport = Transport.new(params[:transport])
    
    if @transport.save
      redirect_to @transport, :notice => I18n.t('transports.create.messages.saved')
    else
      render :action => :new
    end
    
  end
  
  def show
  end
  
  def index
    @transports = Transport.all
  end
  
  def edit
  end
  
  def update
    if @transport.update_attributes(params[:transport])
      redirect_to @transport, :notice => I18n.t('transports.update.messages.saved')
    else
      render :action => :edit
    end
  end
  
  private
  def find_transport
    @transport = Transport.find(params[:id])
  end
end