# encoding: utf-8

require 'acceptance/acceptance_helper'

feature 'Reviewing the details of a line: '  do
  
  before(:each) do
    @line=Factory(:red_line, :transport_id => Factory(:metro).id)
  end
    
  describe "when visiting the details page for a subway transport mode system" do
    before(:each) do
      visit line_path(@line)
      sections_menu_should_be_visible 
    end  
    
    scenario "should show it's main details" do
      page.should have_content @line.transport.name
      page.should have_content @line.name
      page.should have_content @line.name_by_directions
      
      find_link I18n.t('actions.edit')
      find_link I18n.t('actions.back')
    end
    
    scenario "should let me add a new way to the line", :js => true do
      click_on I18n.t('ways.new.title')
      fill_in "way_content", :with => "-99.13955021914663,19.34375187346597,0 -99.14146374212993,19.34383717087054,0"
      fill_in "way_description", :with => "Curva conectando x punto con y punto"
      click_on I18n.t('actions.add')
      
      page.should have_content I18n.t('ways.create.messages.saved')
      page.current_path.should == line_path(Line.first)
      page.should_not have_content I18n.t('ways.index.no_records')
      
      page.should have_content "Vector de coordenadas con 2 elementos"
      page.should have_content "Curva conectando x punto con y punto"
      click_on I18n.t('actions.delete')
      
      page.driver.browser.switch_to.alert.accept
      
      page.current_path.should == line_path(Line.first)
      page.should have_content I18n.t('ways.destroy.messages.done')
      page.should_not have_content "Curva conectando x punto con y punto"
      page.should have_content I18n.t('ways.index.no_records')
    end
    
    scenario "should NOT let me add empty paths to the line", :js => true do      
      click_on I18n.t('ways.new.title')
      fill_in "way_content", :with => ""
      fill_in "way_description", :with => ""
      click_on I18n.t('actions.add')
      page.should have_content I18n.t('ways.create.messages.not_saved')
    end
    
    scenario "should let me add stations to the line", :js => true do
      page.should have_content I18n.t('stations.index.title')
      page.should have_content I18n.t('stations.index.no_records')
      
      click_on I18n.t('stations.new.title')
      page.current_path.should == new_line_station_path(@line)
      
      page.should have_content I18n.t('stations.new.title')
      page.should have_content @line.transport.name
      page.should have_content @line.name
      page.should have_content @line.name_by_directions
      
      fill_in "station_name", :with => "Observatorio"
      simulate_click_on_map({:lat => 19.42007620847585, :lon => -99.25376930236814})
      check "station_is_accessible"
      
      select I18n.t('selectable_options.bike_parking.internal'), :from => "station_bike_parking"
      
      check "station_is_terminal"
      
      click_on I18n.t('actions.save')
      
      page.current_path.should == line_path(@line)
      page.should have_content I18n.t('stations.create.messages.saved')
      page.should have_content I18n.t('stations.index.title')
      
      page.should have_content "Observatorio"
      page.should have_content I18n.t("stations.types.terminal")
      find_link I18n.t('actions.edit')
      find_button I18n.t('actions.delete')
    end
    
    scenario "should NOT let me add an station with empty values to the line", :js => true do
      click_on I18n.t('stations.new.title')
      page.current_path.should == new_line_station_path(@line)
      
      click_on I18n.t('actions.save')
      page.current_path.should == stations_path
      page.should have_content I18n.t('stations.create.messages.not_saved')
    end
    
    describe "having an station registered before" do
      
      before(:each) do
        @observatorio = register_new_station_with("Observatorio", @line)
      end

      scenario "should let me delete it", :js => true do
        visit line_path(@line)
        
        page.should have_content @observatorio.name
        click_button I18n.t('actions.delete')
        page.driver.browser.switch_to.alert.accept
        page.current_path.should == line_path(@line)
        page.should have_content I18n.t('stations.destroy.messages.done')
        
        page.should have_content I18n.t('stations.index.no_records')
      end
      
      scenario "it's name can be changed", :js => true do
        visit line_path(@line)
        
        page.should have_content @observatorio.name
        click_link I18n.t('actions.edit')
        page.current_path.should == edit_station_path(Station.first)
        
        fill_in "station_name", :with => "Insurgentes"
        uncheck "station_is_terminal"
        check "station_is_accessible"
        select I18n.t('selectable_options.bike_parking.external'), :from => "station_bike_parking"
        
        
        click_on I18n.t('actions.save')
        page.should have_content I18n.t('stations.update.messages.saved')
        
        page.should have_content "Insurgentes"
        page.should have_content I18n.t("stations.types.non_terminal")
      end
      
      scenario "it's coordinates can be changed", :js => true do
        visit line_path(@line)
        
        click_link I18n.t('actions.edit')
        page.current_path.should == edit_station_path(Station.first)
        simulate_click_on_map({:lat => 19.22007620847585, :lon => -99.15376930236814})
        click_on I18n.t('actions.save')
        page.should have_content I18n.t('stations.update.messages.saved')
        
      end
      
      describe "having registered an additional station" do

        before(:each) do
          @tacubaya = register_new_station_with("Tacubaya", @line)
        end
        
        scenario "adding a segment with the same station as origin and endpoint should NOT be possible", :js => true do
        
          click_on I18n.t('segments.new.title')
          page.should have_content I18n.t('segments.new.title')
          select @observatorio.name, :from => "segment_origin_station_id"
          select @observatorio.name, :from => "segment_destination_station_id"
          
          click_on I18n.t('actions.save')
          page.should have_content I18n.t('segments.create.messages.not_saved')
          page.current_path.should == segments_path
        end
        
        scenario "adding a repeated segment should NOT be possible", :js => true do
          page.should have_content I18n.t('segments.index.title')
          
          click_on I18n.t('segments.new.title')
        
          page.should have_content I18n.t('segments.new.title')
        
          select @observatorio.name, :from => "segment_origin_station_id"
          select @tacubaya.name, :from => "segment_destination_station_id"
        
          check "segment_double_direction"
        
          fill_in "segment_distance", :with => "12"
        
          click_on I18n.t('actions.save')
          page.should have_content I18n.t('segments.create.messages.saved')
          page.current_path.should == line_path(@line)
          
          page.should have_content I18n.t('segments.index.title')
          
          click_on I18n.t('segments.new.title')
        
          page.should have_content I18n.t('segments.new.title')
        
          select @observatorio.name, :from => "segment_origin_station_id"
          select @tacubaya.name, :from => "segment_destination_station_id"
        
          check "segment_double_direction"
        
          fill_in "segment_distance", :with => "12"
        
          click_on I18n.t('actions.save')
          page.should have_content I18n.t('segments.create.messages.not_saved')
          page.current_path.should == segments_path
        end
        
        
        scenario "adding a segment which connects two stations, modify it and delete it", :js => true do
          page.should have_content I18n.t('segments.index.title')
          
          click_on I18n.t('segments.new.title')
        
          page.should have_content I18n.t('segments.new.title')
        
          select @observatorio.name, :from => "segment_origin_station_id"
          select @tacubaya.name, :from => "segment_destination_station_id"
        
          check "segment_double_direction"
        
          fill_in "segment_distance", :with => "12"
        
          click_on I18n.t('actions.save')
          page.should have_content I18n.t('segments.create.messages.saved')
          page.current_path.should == line_path(@line)
        
          within("#segment-#{Segment.first.id}") do
            page.should have_content @observatorio.name
            page.should have_content "<->"
            page.should have_content @tacubaya.name
            click_on I18n.t('actions.edit')
          end
          
          page.should have_content I18n.t('segments.edit.title')
        
          select @tacubaya.name, :from => "segment_origin_station_id"
          select @observatorio.name, :from => "segment_destination_station_id"
        
          uncheck "segment_double_direction"
        
          fill_in "segment_distance", :with => "1.3"
        
          click_on I18n.t('actions.save')
          page.should have_content I18n.t('segments.update.messages.saved')
          page.current_path.should == line_path(@line)
          
          within("#segment-#{Segment.first.id}") do
            page.should have_content @tacubaya.name
            page.should have_content ">"
            page.should have_content @observatorio.name
            click_on I18n.t('actions.delete')
          end
          
          page.driver.browser.switch_to.alert.accept
          page.current_path.should == line_path(@line)
          page.should have_content I18n.t('segments.destroy.messages.done')

          page.should have_content I18n.t('segments.index.no_records')
          
        end
        
        describe "with an station registered on another line" do
          
          before(:each) do
            @line_two=Factory(:blue_line, :transport_id => Factory(:metro).id)
            visit line_path(@line_two)
            @tacubaya_dos = register_new_station_with("Tacubaya", @line_two)
          end
          
          scenario "adding a connection between two stations, modify it and delete it", :js => true do
            visit line_path(@line)
            page.should have_content I18n.t('connections.index.title')
          
            click_on I18n.t('connections.new.title')
        
            page.should have_content I18n.t('connections.new.title')
        
            select @tacubaya.name, :from => "connection_one_station_id"
            select @tacubaya_dos.name, :from => "connection_another_station_id"
                    
            check "connection_is_accessible"
            
            select(I18n.t('selectable_options.length.large'), :from => "connection_length")
            select(I18n.t('selectable_options.kind.internal'), :from => "connection_kind")
          
            click_on I18n.t('actions.save')
            page.should have_content I18n.t('connections.create.messages.saved')
            page.current_path.should == line_path(@line)
            
            visit line_path(@line_two)
            within("#connection-#{Connection.first.id}") do
              within(".one") do
                page.should have_content @tacubaya_dos.name
              end
              within(".another") do
                page.should have_content @tacubaya.name
              end
              click_on I18n.t('actions.edit')
            end
          
            page.should have_content I18n.t('connections.edit.title')
            
            select @observatorio.name, :from => "connection_another_station_id"
            
            select(I18n.t('selectable_options.length.short'), :from => "connection_length")
            uncheck "connection_is_accessible"
            select(I18n.t('selectable_options.kind.external'), :from => "connection_kind")
        
            click_on I18n.t('actions.save')
            page.should have_content I18n.t('connections.update.messages.saved')
            page.current_path.should == line_path(@line_two)
          
            within("#connection-#{Connection.first.id}") do
              within(".one") do
                page.should have_content @tacubaya_dos.name
              end
              within(".another") do
                page.should have_content @observatorio.name
              end
              click_on I18n.t('actions.delete')
            end
          
            page.driver.browser.switch_to.alert.accept
            page.current_path.should == line_path(@line_two)
            page.should have_content I18n.t('connections.destroy.messages.done')

            page.should have_content I18n.t('connections.index.no_records')
          
          end
        end
      end
    end
    
    describe "automatically generating the simple routes for a line" do
      
      it "should not be possible when one or both of the line terminals cannot be found" do
        page.should have_content I18n.t('lines.index.traversals.cannot_generate')
      end
      
      describe "when having both line terminals registered" do
        
        before(:each) do
          Factory(:station, :name => @line.right_terminal, :line_id => @line.id)
          Factory(:station, :name => @line.left_terminal, :line_id => @line.id)
        end
        
        it "should be possible" do
          visit line_path(@line)
          
          page.should have_content I18n.t('lines.index.traversals.can_generate')
          click_on I18n.t('lines.index.traversals.generate')
          page.should have_content I18n.t('lines.create.messages.traversals.generated')
          page.current_path.should == line_path(@line)
          
          page.should have_content I18n.t('lines.index.traversals.traversal')
          page.should have_content @line.right_terminal
          page.should have_content @line.left_terminal
          
          page.should have_content I18n.t('lines.index.traversals.traversal')
          page.should have_content @line.left_terminal
          page.should have_content @line.right_terminal
          
          page.should have_content I18n.t('lines.index.traversals.generated')
          click_on I18n.t('lines.index.traversals.destroy')
          page.should have_content I18n.t('lines.destroy.messages.traversals.done')
          page.current_path.should == line_path(@line)
        end
        
      end
      
    end
    
  end
end

def register_new_station_with(name, line)
  click_on I18n.t('stations.new.title')
  page.current_path.should == new_line_station_path(line)
  
  page.should have_content I18n.t('stations.new.title')
  page.should have_content line.transport.name
  page.should have_content line.name
  page.should have_content line.name_by_directions
  
  fill_in "station_name", :with => name
  simulate_click_on_map({:lat => 19.42007620847585, :lon => -99.25376930236814})
  
  check "station_is_terminal"
  
  click_on I18n.t('actions.save')
  Station.last
end