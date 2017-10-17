require "test_helper"

describe Merchant do
  let(:merchant) { Merchant.new }

  it "must be valid" do
    value(merchant).must_be :valid?
  end
end
