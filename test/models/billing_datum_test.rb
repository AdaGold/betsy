require "test_helper"

describe BillingDatum do
  let(:datum) { billing_data(:one) }

  it "billing data should be valid" do
    datum.must_be :valid?
  end

  it "Should return invalid without an email address" do
    datum.valid?.must_equal true
    datum.email = nil
    datum.valid?.must_equal false
  end

  it "Should return invalid without a mailing address" do
    datum.valid?.must_equal true
    datum.mailing_address = nil
    datum.valid?.must_equal false
  end

  it "Should return invalid without a credit card name " do
    datum.valid?.must_equal true
    datum.credit_card_name = nil
    datum.valid?.must_equal false
  end

  it "Should return invalid without a credit card number " do
    datum.valid?.must_equal true
    datum.credit_card_number = nil
    datum.valid?.must_equal false
  end

  it "Should return invalid without a credit card cvv " do
    datum.valid?.must_equal true
    datum.credit_card_cvv = nil
    datum.valid?.must_equal false
  end

  it "Should return invalid without a billing zipcode " do
    datum.valid?.must_equal true
    datum.billing_zip_code = nil
    datum.valid?.must_equal false
  end
end
