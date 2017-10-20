require "test_helper"

describe CategoriesController do

    it "succeeds with all category types" do
      %w(clothes shoes music).each do |category|
          Category.by_category(category).length.must_be :>, 0, "No #{category.pluralize} in the test fixtures"
      end

    get root_path
    must_respond_with :success
    end

    it "succeeds with no categories" do
      Category.destroy_all
      get root_path
      must_respond_with :success
    end

    describe "index" do
      it "succeeds when there are categories" do
        Category.count.must_be :>, 0, "There are no categories in the test fixtures"
        get categories_path
        must_respond_with :success
      end

      it "succeeds when there are no categories" do
        Category.destroy_all
        get categories_path
        must_respond_with :success
      end
    end

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
