require 'csv'
require_relative '../app/models/legislator'

NEEDED_FIELDS = ["state","title","firstname","lastname","middlename","name_suffix","phone","fax","website","webform","party","in_office","gender","birthdate","twitter_id"]


class SunlightLegislatorsImporter

  def self.import(filename)
    attribute_hash = {}
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      name_array = []
      row.each do |field, value|
        if needed_field?(field) == true
          if field == "phone" || field == "fax"
            value = value.gsub(/(\d{3}).(\d{3}).(\d{4})/,'\1\2\3') if value != ""
          end

          if self.valid_name_field?(field)
            name_array << value if value != ""
          else
            attribute_hash[field.to_sym] = value #potentially have to fiddle with input values (all strings)
          end
        end
        # raise NotImplementedError, "TODO: figure out what to do with this row and do it!"
      end
      attribute_hash[:name] = name_array.join(' ')
      p attribute_hash
      legislator = Legislator.create!(attribute_hash)
    end
  end


  private

  def self.valid_name_field?(field)
    field == "firstname" || field == "lastname" || field == "middlename" || field == "name_suffix"
  end


  def self.needed_field?(field)
    NEEDED_FIELDS.include?(field)
  end

end

# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end
