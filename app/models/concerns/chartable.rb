# Helper methods used to make Google Charts
module Chartable

  # Adopted vs Orphaned Block Pie Chart
  def adopted_chart
    return [
        ['Status', 'Blocks'],
        ['Adopted',     blocks.adopted.count],
        ['Unadopted',   blocks.orphaned.count]
      ]
  end

  # Cleanings per month
  def year_chart
    #Date.today.at_beginning_of_month.last_month
    i = 0
    month = Date.today.at_beginning_of_month
    cleanings_array = []
    while i < 6 do
      cleanings_array << [month.strftime('%b %y'), cleanings.where('time >= ? AND time < ?', month, month.next_month).count]
      month = month.last_month
      i+=1
    end
    cleanings_array.reverse!
    return cleanings_array.unshift(["Month", "Cleanings"])
  end

  # Blocks getting the most cleanings
  def busiest_chart
    busiest  = {}
    blocks.all.each do |block|
       busiest[block.id] = {name: block.name, cleanings: block.cleanings.where('time > ?', Time.now - 90.days).count}
    end

    # Sort the Hash by Cleanings Most to Least
    busiest = busiest.sort_by {|_key, value| -value[:cleanings]}
    # Convert the Hash into a 2D Array of [Name, Cleanings] and only take the first 5 elements
    busiest = busiest.map{ |_key,value| [value[:name], value[:cleanings]] }[0..2]
    # Throw Headers on there 
    busiest = busiest.unshift(["Block", "Cleanings"])
    return busiest
  end

end
