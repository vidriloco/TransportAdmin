require 'acceptance/acceptance_helper'

feature 'Listing of vehicles: '  do
  
  describe "having no vehicles registered when visiting the index page" do

    before(:each) do
      visit vehicles_path
      sections_menu_should_be_visible

      page.should have_content I18n.t('vehicles.index.title')
      find_link I18n.t('actions.vehicles.add')
    end
    
    it "should show a 'no vehicles registered' message" do
      page.should have_content I18n.t('vehicles.index.no_records')
    end
  end
  
  describe "having a vehicle registered" do
    
    before(:each) do
      @metro=Factory(:metro)
      bl=Factory(:blue_line, :transport_id => @metro.id)
      @vh=Factory(:vehicle, :line_id => bl)
    end
    
    describe "when visiting the index page" do
    
      before(:each) do
        visit vehicles_path
        sections_menu_should_be_visible
    
        page.should have_content I18n.t('vehicles.index.title')
        find_link I18n.t('actions.vehicles.add')
      end  
    
      it "should list it" do
        within("#vehicle-#{@vh.id}") do
          page.should have_content @vh.identifier
          page.should have_content @vh.description

          page.should have_content I18n.t('activerecord.attributes.vehicle.line')
          page.should have_content @vh.line.line_transport
          find_link I18n.t('actions.edit')
        end
      end
    end
  end
end