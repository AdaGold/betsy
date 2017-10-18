require "test_helper"

describe ReviewsController do

  describe "Athenticated User" do
    it "allows authenticated users to leave a review" do

    end

    it "does NOT allow authenticated users who are the product vendors to review their own products" do

    end

    # it "allows an auth-user to see the reviews index page " do
    #
    # end
    #
    # it "allows an auth-user to see a review's show page" do
    #
    # end

    it "should re-render the review create form if it cannot create a review (if fields are missing)" do

    end

    it "allows an auth-user to delete a review, if they created the review" do

    end

    it "allows an auth-user to edit a review that they created" do

    end

    it "should re-render the review edit page if it cannot successfully edit the review" do
    end


  end

  describe "Guest (Unauthenticated) User" do
    it "allows UN-authenticated users to leave a review" do


    end

    it "does not allow a guest to edit any reviews, even their own" do

    end

    it "does not allow a guest to delete any reviews, even their own" do

    end

    it "allows an auth-user to see the reviews index page " do
      get books_path
      must_respond_with :success
    end

    it "allows an auth-user to see a review's show page" do
      get book_path(reviews(:one).id)
      must_respond_with :success
    end

    # it "should respond with 404 if the item review page is not found" do
    # end

  end




end
