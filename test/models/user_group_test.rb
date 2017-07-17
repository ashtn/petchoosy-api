require "test_helper"

describe UserGroup do
  let(:user_group) { UserGroup.new }

  it "must be valid" do
    value(user_group).must_be :valid?
  end
end
