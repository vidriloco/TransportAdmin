class Way < ActiveRecord::Base
  belongs_to :line
  
  validates_presence_of :content, :description
  
  def humanized_content
    return "---" if self.content.nil?
    vector_length = self.content.length
    return I18n.t('ways.show.human_description.one') if vector_length == 1
    I18n.t('ways.show.human_description.other', :number => vector_length)
  end
  
  def self.new_with_filtering(params)
    execute_format_verification_on(params[:content])
    parsed_line_string = parse_klm_coordinates(params.delete(:content))
    Way.new(params.merge(:content => LineString.from_coordinates(parsed_line_string, 4326, false, false)))
  end
  
  private
  def self.parse_klm_coordinates(coords_vector)
    coords_vector.split(" ").each.inject([]) do |collected, item|
      coord_components = item.split(",")
      collected << [coord_components[0].to_f, coord_components[1].to_f] 
      collected
    end
  end
  
  def self.execute_format_verification_on(coords_chunk)
  end
end
