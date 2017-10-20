require "test_helper"

describe CategoriesController do

    describe "index" do
      it "succeeds when there are categories" do
        get categories_path
        must_respond_with :success
      end

      # it "succeeds when there are no categories" do
      #   @categories.destroy_all
      #   get categories_path
      #   must_respond_with :success
      # end
    end

    # describe "show" do
    #   it "can show one category" do
    #     get category_path(categories(:one).id)
    #     must_respond_with :success
    #   end

      # it "cannot show a category that does not exist" do
      #   category_id = Category.last.id + 1
      #   get category_path(category_id)
      #   must_respond_with :redirect
      #   must_redirect_to root_path
      # end

    # end



  #only allow auth-users (not guests) should be able to create new categories (vendors)
  # describe "new" do
  #   it "allows merchant (i.e. user) to create a new category" do
  #     get new_category_path
  #     must_respond_with :success
  #   end
      #
      #it "does not allow guests to create a new category" do
      #
      # end
  # end
  #
  # describe "create" do
  #   it "creates a product with valid data for a real category" do
  #     product_data = {
  #       product: {
  #         name: "test product",
  #         price: 5.99,
  #         user_id: 5,
  #       }
  #     }
  #     CATEGORIES.each do |category|
  #       product_data[:product][:category] = category
  #       #product.save?
  #       #product_data.save?
  #       start_count = Product.count
  #
  #       post products_path(category), params: product_data
  #       must_redirect_to product_path(Product.last)
  #
  #       Product.count.must_equal start_count + 1
  #     end
  #   end
  #
  # end


end
