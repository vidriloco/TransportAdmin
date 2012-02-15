class LinesController < ApplicationController

  def index
    @transports = Transport.find(:all, :include => [:lines, :partitions])

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @line = Line.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @line = Line.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @line = Line.find(params[:id])
  end

  def create
    @line = Line.new(params[:line])

    respond_to do |format|
      if @line.save
        format.html { redirect_to @line, :notice => I18n.t('lines.create.messages.saved') }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @line = Line.find(params[:id])

    respond_to do |format|
      if @line.update_attributes(params[:line])
        format.html { redirect_to @line, :notice => I18n.t('lines.update.messages.saved') }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @line = Line.find(params[:id])
    @line.destroy

    respond_to do |format|
      format.html { redirect_to lines_url, :notice => I18n.t('lines.destroy.messages.done') }
    end
  end
end
