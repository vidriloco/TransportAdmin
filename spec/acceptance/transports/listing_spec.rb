require 'acceptance/acceptance_helper'

feature 'Listing of transports: '  do
  
  describe "having no transports registered when visiting the index page" do

    before(:each) do
      visit transports_path
      sections_menu_should_be_visible

      page.should have_content I18n.t('transports.index.title')
      find_link I18n.t('actions.transports.add')
    end
    
    it "should show a 'no transports registered' message" do
      page.should have_content I18n.t('transports.index.no_records')
    end
  end
  
  describe "having two transports registered" do
    
    before(:each) do
      @metro=Factory(:metro)
      Factory.build(:blue_line, :transport_id => @metro.id)
      Factory.build(:red_line, :transport_id => @metro.id)
      @ecobici=Factory(:ecobici)
      Factory.build(:partition, :transport_id => @ecobici.id)
    end
    
    describe "when visiting the index page" do
    
      before(:each) do
        visit transports_path
        sections_menu_should_be_visible
    
        page.should have_content I18n.t('transports.index.title')
        find_link I18n.t('actions.transports.add')
      end  
    
      it "should list them" do
        within("#transport-#{@metro.id}") do
          find_link @metro.name
          
          find_link I18n.t('actions.lines.see')
        end
        
        within("#transport-#{@ecobici.id}") do
          find_link @ecobici.name
          
          find_link I18n.t('actions.partitions.see')
        end
      end
    end
  end
end