class SegmentsController < ActionController::Base
  layout 'application'
    
  def new
    @line = Line.find(params[:line_id])
    @segment = Segment.new
  end
  
  def create
    @segment = Segment.new(params[:segment])
    @line = @segment.line
    
    if @segment.save
      redirect_to(@segment.line, :notice => I18n.t('segments.create.messages.saved'))
    else
      render :action => :new
    end
  end
  
  def destroy
    @segment = Segment.find(params[:id])
    @segment.destroy
    redirect_to(@segment.line, :notice => I18n.t('segments.destroy.messages.done'))
  end
  
  def edit
    @segment = Segment.includes(:line).find(params[:id])
    @line = @segment.line
  end
  
  def update
    @segment = Segment.find(params[:id])
    @line = @segment.line
    
    if @segment.update_attributes(params[:segment])
      redirect_to(@segment.line, :notice => I18n.t('segments.update.messages.saved'))
    else
      render :action => :edit
    end
  end
  
end