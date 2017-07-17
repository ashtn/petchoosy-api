require "test_helper"

describe PetList do
  let(:pet_list) { PetList.new }

  it "must be valid" do
    value(pet_list).must_be :valid?
  end
end
