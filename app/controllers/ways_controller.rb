class WaysController < ActionController::Base
  def create
    @way=Way.new_with_filtering(params[:way].merge(:line_id => params[:line_id]))
    
    message = @way.save ? { :notice => t('ways.create.messages.saved') } : { :alert => t('ways.create.messages.not_saved') }
    redirect_to @way.line, message
  end
  
  def destroy
    @way=Way.find(params[:id])
    @way.destroy
    redirect_to(@way.line, :notice => t('ways.destroy.messages.done'))
  end
end