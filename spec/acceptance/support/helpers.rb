module HelperMethods
  # Put helper methods you need to be available in all acceptance specs here.
  def sections_menu_should_be_visible
    find_link Transport.model_name.human.pluralize
    find_link Line.model_name.human.pluralize
    find_link Traversal.model_name.human.pluralize
    find_link Vehicle.model_name.human.pluralize
  end
  
  def simulate_click_on_map(coordinates)
    page.execute_script("mapWrap.simulatePinPoint(#{coordinates[:lat]},#{coordinates[:lon]});")
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance