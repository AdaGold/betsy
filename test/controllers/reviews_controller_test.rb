
require "test_helper"

describe ReviewsController do
  describe "Guest (Unauthenticated)" do
    describe "NEW" do
      let(:product) { products(:converse) }
      
      it "Should be able to get to the new review form" do
        get new_review_path(product)
        must_respond_with :success
      end
    end

    describe "CREATE" do
      it "Guests can leave reviews for any product" do
        proc {
          post reviews_path, params: {review: {text: "sample review", rating: 5, user_id: nil, product_id: products(:converse).id } }
        }.must_change 'Review.count', 1

        must_respond_with :redirect
        must_redirect_to product_path(products(:converse).id)
      end

      it "GUESTS cannot leave a review on an unfound product" do
        
      end
    end
  end