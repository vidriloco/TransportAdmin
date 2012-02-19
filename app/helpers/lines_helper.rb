module LinesHelper
  
  def station_for_line(line, connection)
    connection.another_line == line ? connection.one_station_id : connection.another_station_id
  end
end
