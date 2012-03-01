#encoding: utf-8
require 'acceptance/acceptance_helper'

feature 'Adding of a traversal: '  do
  
  describe "Registering a new one from the index page" do
    
    before(:each) do
      @metro=Factory(:metro)
      bl=Factory(:blue_line, :transport_id => @metro.id)
      Factory(:observatorio, :line_id => bl)
      
      @metrobus=Factory(:metrobus)
      bl=Factory(:blue_line, :transport_id => @metrobus.id)
      Factory(:station, :line_id => bl, :name => "Tepalcates")      
    end
    
    describe "when visiting the new traversal page" do
    
      it "should let me add a new traversal" do
        visit traversals_path
        sections_menu_should_be_visible
        page.should have_content I18n.t('traversals.index.title')
        click_link I18n.t('actions.traversals.add')
        
        page.current_path.should == new_traversal_path
        page.should have_content I18n.t('traversals.new.title')
        
        select "Observatorio", :from => "traversal_one_station_id"
        select "Tepalcates", :from => "traversal_another_station_id"
        check "traversal_is_main"
        
        click_on I18n.t('actions.save')
        
        page.should have_content I18n.t('traversals.create.messages.saved')
        page.current_path.should == traversals_path
        
        within("#traversal-#{Traversal.first.id}") do
          page.should have_content Traversal.first.one_station.name
          page.should have_content Traversal.first.another_station.name
          
          page.should have_content I18n.t('traversals.show.is_main')[true]
          
          find_link Traversal.first.one_station.line.transport.name
          
          find_button I18n.t('actions.delete')
          find_link Traversal.first.one_station.line.name
        end
      end
      
      it "should NOT let me add a new traversal if I fail to provide all the required fields" do
        visit traversals_path
        sections_menu_should_be_visible
        page.should have_content I18n.t('traversals.index.title')
        click_link I18n.t('actions.traversals.add')
        
        page.current_path.should == new_traversal_path
        page.should have_content I18n.t('traversals.new.title')
        click_on I18n.t('actions.save')
        
        page.should have_content I18n.t('traversals.create.messages.not_saved')
        page.current_path.should == traversals_path
      end
      
    end
  end
end