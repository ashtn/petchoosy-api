require "test_helper"

describe PetListPet do
  let(:pet_list_pet) { PetListPet.new }

  it "must be valid" do
    value(pet_list_pet).must_be :valid?
  end
end
