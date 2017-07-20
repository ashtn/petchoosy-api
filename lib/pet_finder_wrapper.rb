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
      pets = response['petfinder']['pets']['pet'].map do | pet |
        self.construct_pet(pet)
      end
    end
    return pets
  end

  def self.get_breeds(animal)
    method = "breed.list?key="
    url = "#{BASE_URL}#{method}#{KEY}#{STATIC_ARGS}#{animal}"
    puts url
  end # will need to make api call to find breeds to display them

  def self.get_pet(api_id)
    method = "pet.get?key="

    query = "id=#{api_id}"

    url = "#{BASE_URL}#{method}#{KEY}#{STATIC_ARGS}&#{query}"
    puts 'url =============================='
    puts url

    response = HTTParty.get(url)
    puts 'response ========================'
    ap response

    pet = response['petfinder']['pet']
    puts 'pet ============================='
    ap pet
    # TODO add fav:
    # TODO what happens if pet does not exist? #Let user know pet has be adopted
    if pet
      return construct_pet(pet)
    end
  end

  private

  def self.construct_pet(pet)

    return {
      api_id: pet['id']['$t'], #999
      name: pet['name']['$t'], #999
      media: pet['media'], # TODO only grab size X #999
      description: pet['description']['$t'], #999
      age: pet['age']['$t'], #999
      # lastUpdate: pet['lastUpdate']['$t'],
      # city: pet['contact']['city']['$t'],
      sex: pet['sex']['$t'], #999
      breed: pet['breeds']['breed'], # TODO make array of breeds #999
      # shelterId: pet['shelterId']['$t']
    } # TODO get_shelter()
  end

end

# MATCHERS = "animal=smallfurry&size=M&location=98101&age=young"
# MATCHERS = "animal=smallfurry&breed=Hamster&size=M&location=98101&sex=&age=young"
