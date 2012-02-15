require 'acceptance/acceptance_helper'

feature 'Listing of lines: '  do
  
  before(:each) do
    @metro = Factory(:metro)
  end
  
  describe "having no lines registered when visiting the lines index page for it's transport" do
    
    before(:each) do
      visit transport_lines_path(@metro)
      sections_menu_should_be_visible

      page.should have_content I18n.t('lines.index.title')
      find_link I18n.t('actions.lines.add')
    end
    
    it "should show a 'no lines registered' message" do
      page.should have_content I18n.t('lines.index.no_records')
    end
  end
  
  describe "having two lines registered" do
    
    before(:each) do
      @bl=Factory(:blue_line, :transport_id => @metro.id)
      @rl=Factory(:red_line, :transport_id => @metro.id)
    end
    
    describe "when visiting the index page for it's transport" do
    
      before(:each) do
        visit transport_lines_path(@metro)
        sections_menu_should_be_visible
    
        page.should have_content I18n.t('lines.index.title')
        find_link I18n.t('actions.lines.add')
      end  
    
      it "should list them" do
        within("#line-#{@bl.id}") do
          find_link @bl.name
          page.should have_content @bl.name_by_directions
          
          find_link I18n.t('actions.stations.add')
          find_link I18n.t('actions.stations.see')
        end
        
        within("#line-#{@rl.id}") do
          find_link @rl.name
          page.should have_content @rl.name_by_directions
          
          find_link I18n.t('actions.stations.add')
          find_link I18n.t('actions.stations.see')
        end
      end
    end
  end
  
  describe "having registered an additional transport" do
    
    before(:each) do
      @metrobus = Factory(:metrobus)
    end
    
    it "should let changing "
    
  end
end