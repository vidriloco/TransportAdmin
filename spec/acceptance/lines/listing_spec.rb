require 'acceptance/acceptance_helper'

feature 'Listing of lines: '  do
  
  before(:each) do
    @metro = Factory(:metro)
    @metrobus = Factory(:metrobus)
  end
  
  describe "having two lines registered for metro, and none for metrobus" do
    
    before(:each) do
      @bl=Factory(:blue_line, :transport_id => @metro.id)
      @rl=Factory(:red_line, :transport_id => @metro.id)
    end
    
    describe "when visiting the index page" do
    
      before(:each) do
        visit lines_path
        sections_menu_should_be_visible
    
        page.should have_content I18n.t('lines.index.title')
        find_link I18n.t('actions.lines.add')
      end  
    
      scenario "should list them grouped by transport", :js => true do
        
        within("#transport-#{@metrobus.id}") do
          page.should have_content @metrobus.name
        
          page.should have_content I18n.t('lines.index.no_records')
        end
        
        within("#transport-#{@metro.id}") do
          page.should have_content @metro.name
        
          within("#line-#{@bl.id}") do
            find_link @bl.name
            page.should have_content @bl.name_by_directions
          
            find_button I18n.t('actions.delete')
            find_link I18n.t('actions.edit')
          end
        
          within("#line-#{@rl.id}") do
            find_link @rl.name
            page.should have_content @rl.name_by_directions
          
            find_button I18n.t('actions.delete')
            find_link I18n.t('actions.edit')
          end
        end
      end
    end
  end
  
end