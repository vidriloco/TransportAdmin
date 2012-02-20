#encoding: utf-8
require 'acceptance/acceptance_helper'

feature 'Listing of traversals: '  do

  describe "If I'm on the traversals path with no one registered" do

    before(:each) do
      visit traversals_path
      sections_menu_should_be_visible

      page.should have_content I18n.t('traversals.index.title')
      find_link I18n.t('actions.traversals.add')
    end
    
    it "should show a 'no traversals registered' message" do
      page.should have_content I18n.t('traversals.index.no_records')
    end
  end
  
  describe "having one traversal registered" do
    
    before(:each) do
      @metro=Factory(:metro)
      bl=Factory(:blue_line, :transport_id => @metro.id)
      Factory(:observatorio, :line_id => bl)
      Factory(:station, :line_id => bl, :name => "Pantitlán")
      
      @t1 = Traversal.build_new_between!(bl.left_terminal, bl.right_terminal, :by => [bl.id])
    end
    
    describe "when visiting the index page", :js => true do
    
      before(:each) do
        visit traversals_path
        sections_menu_should_be_visible
        page.should have_content I18n.t('traversals.index.title')
        find_link I18n.t('actions.traversals.add')
      end  
    
      it "should list it" do
        within("#traversal-#{@t1.id}") do
          page.should have_content @t1.one_station.name
          page.should have_content @t1.another_station.name

          find_link @t1.one_station.line.transport.name
          
          find_button I18n.t('actions.delete')
          find_link @t1.one_station.line.name
        end
      end
      
      it "should let me destroy it" do
        within("#traversal-#{@t1.id}") do
          click_button I18n.t('actions.delete')
        end
        
        page.driver.browser.switch_to.alert.accept
        
        page.current_path.should == traversals_path
        page.should have_content I18n.t('traversals.destroy.messages.done')
        page.should have_content I18n.t('traversals.index.no_records')
      end
      
    end
  end
end