require "test_helper"

describe MainPageController do
  it "should get index" do
    get main_page_index_url
    value(response).must_be :success?
  end

end
