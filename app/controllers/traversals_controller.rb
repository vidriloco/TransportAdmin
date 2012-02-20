class TraversalsController < ApplicationController
  layout 'application'
  
  before_filter :find_line, :only => [:generate_automatic, :destroy_automatic]
  
  def index
    @traversals = Traversal.all
  end
  
  def destroy
    @traversal = Traversal.find(params[:id])
    @traversal.destroy
    
    redirect_to :back, :notice => I18n.t('traversals.destroy.messages.done')
  end
  
  def new
    @traversal = Traversal.new
  end
  
  def create
    @traversal = Traversal.new(params[:traversal])
    
    if @traversal.save
      redirect_to(traversals_path, :notice => I18n.t('traversals.create.messages.saved'))
    else
      render :action => :new
    end
  end
  
  def generate_automatic
    @line.generate_basic_traversals if @line.can_generate_basic_traversals?
    
    redirect_to(@line, :notice => I18n.t('lines.create.messages.traversals.generated'))
  end
  
  def destroy_automatic
    @line.basic_traversals.each { |traversal| traversal.destroy }
    
    redirect_to(@line, :notice => I18n.t('lines.destroy.messages.traversals.done'))
  end
  
  private
  
  def find_line
    @line = Line.find(params[:line_id])
  end
end