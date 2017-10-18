require "test_helper"

describe Entry do
  let(:entry) { Entry.new }

  it "must be valid" do
    value(entry).must_be :valid?
  end
end
