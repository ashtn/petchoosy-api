require 'httparty'
require 'awesome_print'

class PetFinderWrapper

  BASE_URL = "http://api.petfinder.com/"
  STATIC_ARGS= "&format=json&output=full"
  KEY = ENV['API_KEY']

  def self.find_pets(query)

    method = "pet.find?key="

    url = "#{BASE_URL}#{method}#{KEY}#{STATIC_ARGS}&#{query}"

    puts url # TODO remove

    response = HTTParty.get(url)

    if response['petfinder']['pets'] == 0
      return []
    else
      pets = response['petfinder']['pets']['pet'].map do | animal |
        self.construct_pet(animal)
      end
    end
    return pets
  end

  def self.get_breeds(animal)
    method = "breed.list?key="
    url = "#{BASE_URL}#{method}#{KEY}#{STATIC_ARGS}#{animal}"
    puts url
  end # will need to make api call to find breeds to display them

  private

  def self.construct_pet(animal)

    return {
      api_id: animal['id']['$t'],
      name: animal['name']['$t'],
      media: animal['media'], # TODO only grab size X
      description: animal['description']['$t'],
      age: animal['age']['$t'],
      # lastUpdate: animal['lastUpdate']['$t'],
      city: animal['contact']['city']['$t'],
      sex: animal['sex']['$t'],
      breed: animal['breeds']['breed'],
      shelterId: animal['shelterId']['$t'] } # TODO get_shelter()
  end

end

# MATCHERS = "animal=smallfurry&size=M&location=98101&age=young"
# MATCHERS = "animal=smallfurry&breed=Hamster&size=M&location=98101&sex=&age=young"
