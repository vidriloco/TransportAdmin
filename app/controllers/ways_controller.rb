class WaysController < ActionController::Base
  def create
    @way=Way.new_with_filtering(params[:way].merge(:line_id => params[:line_id]))
    
    if @way.save
      redirect_to @way.line, :notice => t('ways.create.messages.saved')
    else
      render :nothing => true
    end
  end
  
  def destroy
    @way=Way.find(params[:id])
    @way.destroy
    redirect_to(@way.line, :notice => t('ways.destroy.messages.done'))
  end
end