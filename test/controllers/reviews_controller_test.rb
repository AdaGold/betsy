require "test_helper"

describe ReviewsController do
  let(:product) {products(:tree1)}
  let(:merchant) {merchants(:sappy1)}

  it "should get new if no one is signed in" do
    get new_review_path(products(:tree1).id)
    must_respond_with :success
  end

  it "should redirect to the product page if the merchant of the product is signed in" do
    login(merchant, :github)
    flash[:status] = :error
    must_respond_with :redirect
    # must_redirect_to product_path(product.id)
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

      must_respond_with :redirect
    end

    it "should reroute a merchant to the product page and a flash message should notify them that they can't leave a review " do
      @merchant = merchants(:sappy1)
      login(@merchant, :github)
      proc {
        post reviews_path, params: { review: { title: "Super title", review_text: "Super duper review", rating: 4, product_id: products(:tree1).id } }
      }.must_change 'Review.count', 0
      must_respond_with :forbidden
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
