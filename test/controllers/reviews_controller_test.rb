require "test_helper"

describe ReviewsController do

  it "should get new" do
    get reviews_path
    must_respond_with :success
  end

  it "should be able to successfully create a review" do
      proc {
        post reviews_path, params: { review: { title: "Review Title", review_text: "Super duper review", rating: 4, product_id: products(:tree1).id } }
      }.must_change 'Review.count', 1

      must_respond_with :redirect

    end


    it "should rerender the form and not update the review table if it can't create the review" do
      proc {
        post reviews_path, params: { review: { title: "", review_text: "Super duper review", rating: 4, product_id: products(:tree1).id } }
      }.must_change 'Review.count', 0

      must_respond_with :success
    end

  # it "should get show" do
  #   get reviews_show_url
  #   value(response).must_be :success?
  # end
  #
  #
  # it "should get edit" do
  #   get reviews_edit_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get update" do
  #   get reviews_update_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get index" do
  #   get reviews_index_url
  #   value(response).must_be :success?
  # end
  #


end
