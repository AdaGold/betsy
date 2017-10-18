require "test_helper"

describe Category do
  let(:category) { Category.new }

  it "must be valid" do
    value(category).must_be :valid?
  end
end
