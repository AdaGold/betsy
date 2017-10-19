require "test_helper"

describe BillingDatum do
  let(:billing_datum) { BillingDatum.new }

  it "must be valid" do
    value(billing_datum).must_be :valid?
  end
end
