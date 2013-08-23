require_relative 'models/legislator'

def find_state_legislators(state)
  sen_array = Legislator.where(:state => state, :title => 'Sen')
  rep_array = Legislator.where(:state => state, :title => 'Rep')
  puts "Senators"
  sen_array.each { |senator| puts "  #{senator.name} (#{senator.party})" }
  puts "Representatives"
  rep_array.each { |rep| puts "  #{rep.name} (#{rep.party})" }
end

# find_state_legislators('NY')

def gender_percentage(gender)
  active_sen = Legislator.where(:title => 'Sen', :in_office => 1).count
  active_rep = Legislator.where(:title => 'Rep', :in_office => 1).count
  active_gender_sen = Legislator.where(:title => 'Sen', :in_office => 1, :gender => gender).count
  active_gender_rep = Legislator.where(:title => 'Rep', :in_office => 1, :gender => gender).count
  puts "#{gender} Senators: #{active_gender_sen} (#{((active_gender_sen.to_f/active_sen) * 100).round}%)"
  puts "#{gender} Reps: #{active_gender_rep} (#{((active_gender_rep.to_f/active_rep) * 100).round}%)"
end

# gender_percentage("M")
# gender_percentage("F")

def active_state_count
  test = Legislator.where(:in_office => 1, :title => 'Sen', :title => 'Rep').group(:state).order("count(legislators.id) DESC").count
  test.each {|key, value| puts "#{key}: 2 Senators, #{value} Representative(s)"}
end

# active_state_count

def active_legislator_count
  active_sen = Legislator.where(:title => 'Sen').count
  active_rep = Legislator.where(:title => 'Rep').count
  p "Senators: #{active_sen}"
  p "Representatives: #{active_rep}"
end

# active_legislator_count

def delete_inactive
  Legislator.destroy_all(:in_office => 0)
end

delete_inactive
active_legislator_count