require "test_helper"

describe PetListInterest do
  let(:pet_list_interest) { PetListInterest.new }

  it "must be valid" do
    value(pet_list_interest).must_be :valid?
  end
end
