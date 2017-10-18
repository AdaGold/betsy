require "test_helper"

describe BillingDataController do
  describe "Index" do
    it "should not show a list of all billing data" do
      get billing_data_path
      must_respond_with :bad_request
    end
  end

  describe "creating new billing information" do
    it "it should produce a form for entering payment information" do
      get new_billing_data_path
      must_respond_with :success
    end

    it "should create new billing information with valid information" do
      billing_data = {
        billing: {
          email: "test@testdata.com",
          mailing_address: "2200 New Street, Seattle, WA, 09020",
          credit_card_name: "test card",
          credit_card_number: "4332 2321 1213 1241",
          credit_card_cvv: "333",
          billing_zip_code: "09020"
        }
      }
      proc {post billing_data_path, params: billing_data }.must_change 'BillingDatum.count', 1

      must_respond_with :redirect
      must_redirect_to billing_data_path(BillingDatum.last.id)
    end

    it "should not create new billing information when valid data isn't present" do
      billing_data = {
        billing: {
          email: "test@testdata.com",
          mailing_address: "2200 New Street, Seattle, WA, 09020",
          credit_card_name: "test card",
          credit_card_number: "4332 2321 1213 1241",
          credit_card_cvv: "333",
          billing_zip_code: "09020"
        }
      }

      billing_data.each do |key, value|
        billing_data[key] = nil

        proc {post billing_data_path, params: billing_data }.must_change 'BillingDatum.count', 0
        must_respond_with :bad_request
      end
    end

    

  end



  it "should produce an edit form for billing data" do
    get edit_billing_data_path(billing_data(:one))
    must_respond_with :redirect
    must_redirect_to :update
  end

  it "should update billing information" do
    put update_billing_data(billing_data(:one))
    must_respond_with :redirect
    must_redirect_to show_billing_info_path(billing_data(:one))
    #should redirect to the "show billing info/confirm purchase" page
  end

  it "should get destroy" do
    delete billing_data_path(billing_data(:one))
    must_respond_with :redirect
  end

end
