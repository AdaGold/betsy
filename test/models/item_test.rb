require "test_helper"

describe Item do
  let(:item) { Item.new }

  it "must be valid" do
    value(item).must_be :valid?
  end
end
