require 'rubygems'
require 'faker'
require 'csv'

class Person
  attr_accessor :first_name, :last_name, :email, :phone, :created_at

  def initialize(first_name, last_name, email, phone, created_at)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @phone = phone
    @created_at = created_at
  end
end

def persons(num_persons)
  people = []
  num_persons.times do |num|
    people << Person.new(Faker::Name.first_name, Faker::Name.last_name, Faker::Internet.email, Faker::PhoneNumber.phone_number, Time.now)
  end
  people
end

class PersonWriter 
  def initialize(archive, list)
    @archive = archive
    @list = list
  end

  def create_csv
    #leer array de objetos personas
    #abrir csv y grabar personas en csv (formato texto)
    CSV.open(@archive, 'wb') do |csv|
      @list.each do |list_p|
        csv << [list_p.first_name, list_p.last_name, list_p.email, list_p.phone, list_p.created_at]
      end
    end
  end
end


class PersonParser 
  
  def initialize(archive)
    @archive = archive
  end

  def people
    person = []
    CSV.foreach(@archive) do |row|
      person << Person.new(row[0], row[1], row[2], row[3], row[4])
    end 
    person[0..9]
  end
end

class SearchPerson
  def initialize(file, person_name)
    @file = file
    @person_name = person_name
  end

  def get_data
    person = []
    CSV.foreach(@file) do |row|
      person << Person.new(row[0], row[1], row[2], row[3], row[4])
    end 
    person
  end

  def change_name(new_person_name)
    people_list = get_data
    people_list.each do |person|
      person.first_name = new_person_name if person.first_name == @person_name
    end
    p people_list
    #grabar people_list en el archivo csv    
  end

  def save_data(list_new)
    CSV.open(@file, 'wb') do |csv_save|
      list_new.each do |save_l|
        csv_save << [save_l.first_name, save_l.last_name, save_l.email, save_l.phone, save_l.created_at]
      end
    end
  end
end

# people_list = persons(20)
# person_writer = PersonWriter.new("people.csv", people_list)
# person_writer.create_csv

# parser = PersonParser.new('people.csv')
# people = parser.people

search = SearchPerson.new("people.csv", "Clotilde")
p list_new = search.change_name("Martin")


search.save_data(list_new)


# def suma(a, b)
#   a + b
# end

# p sum_value = suma(8, 3)

# def resta(a, b)
#   a - b
# end

# p resta(sum_value, 2)


