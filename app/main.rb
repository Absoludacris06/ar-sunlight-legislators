require_relative 'models/legislator'

def find_state_legislators(state)
  sen_array = []
  rep_array = []
  sen_array = Legislator.where(:state => state, :title => 'Sen')
  rep_array = Legislator.where(:state => state, :title => 'Rep')
  puts "Senators"
  sen_array.each { |senator| puts "  #{senator.name} (#{senator.party})" }
  puts "Representatives"
  rep_array.each { |rep| puts "  #{rep.name} (#{rep.party})" }
end

find_state_legislators('NY')
