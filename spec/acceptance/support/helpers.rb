module HelperMethods
  # Put helper methods you need to be available in all acceptance specs here.
  def sections_menu_should_be_visible
    find_link Transport.model_name.human.pluralize
    find_link Line.model_name.human.pluralize
    find_link Station.model_name.human.pluralize
    find_link Connection.model_name.human.pluralize
    find_link Traversal.model_name.human.pluralize
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance