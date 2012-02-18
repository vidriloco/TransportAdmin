module Neo

  @neo = nil
  
  def neo_server
    @neo || @neo = Neography::Rest.new
  end
  
end