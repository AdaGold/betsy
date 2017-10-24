#
# require "test_helper"
#
# describe ReviewsController do
#
#   # describe "Athenticated User" do
#   #   it "allows authenticated users to leave a review" do
#   #   end
#   #
#   #   it "does NOT allow authenticated users who are the product vendors to create reviews for their own products" do
#   #   end
#   #
#   #   it "allows an auth-user to see the reviews index page " do
#   #   end
#   #
#   #   it "allows an auth-user to see a review's show page" do
#   #   end
#   #
#   #   it "should re-render the review create form if it cannot create a review (if fields are missing)" do
#   #   end
#   #
#   #   it "allows an auth-user to delete a review, if they created the review" do
#   #   end
#   #
#   #   it "allows an auth-user to edit a review that they created" do
#   #   end
#   #
#   #   it "should re-render the review edit page if it cannot successfully edit the review" do
#   #   end
#   #
#   # it "allows an auth-user to see the reviews index page " do
#   #   get books_path
#   #   must_respond_with :success
#   # end
#   #
#   # it "allows an auth-user to see a review's show page" do
#   #   get book_path(reviews(:one).id)
#   #   must_respond_with :success
#   # end
#
#
#   # end
#
#   # ------------------------TODO--------------------------
#   describe "Guest (Unauthenticated)" do
#
#     describe "NEW" do
#       let(:product) { products(:converse) }
#
#       it "Should be able to get to the new review form" do
#
#         get new_review_path(product)
#         must_respond_with :success
#
#       end
#     end
#
#     describe "CREATE" do
#       let(:product) { products(:converse) }
#
#       it "GUESTS can leave a review on any product" do
#
#         # end
#         #
#         # it "GUESTS cannot leave a review on an unfound product" do
#         # end
#       end
#
#
#
#       # describe "EDIT" do
#       #   it "Can only edit a review that you posted" do
#       #   end
#       #
#       #   it "Cannot edit a review that is not your own" do
#       #   end
#       # end
#
#
#
#       # describe "DELETE" do
#       #   it "Cannot delete a review, even if it is your own" do
#       #   end
#       # end
#
#
#
#       # describe "show" do
#       #   it "Can view a review" do
#       #   end
#       #
#       #   it "Cannot view a review that " do
#       #
#       #   end
#       # end
#
#
#
#
#
#       # it "should respond with 404 if the item review page is not found" do
#       # end
#     end
#   end
# end
