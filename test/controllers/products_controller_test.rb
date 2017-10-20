require "test_helper"

describe ProductsController do
  let(:one) {products(:tree1)}

  describe "index" do
    it "must get the index view" do
      get products_path
      must_respond_with :success
    end

    it "must respond with success with valid filter parameters" do
      #valid category
      get products_path, params: {category: one.category}
      must_respond_with :success
      #valid merchant
      get products_path, params: {merchant: one.merchant.id}
      must_respond_with :success
      #valid category and merchant
      get products_path, params: {category: one.category, merchant: one.merchant.id}
      must_respond_with :success
    end

    it "must respond with a 404 (400?) if any filter parameters are invalid" do
      skip
    end
  end

  it "must get the show view" do
    get product_path(one.id)
    must_respond_with :success

    get product_path(-1)
    must_respond_with :redirect
    must_redirect_to root_path
  end

  it "should get new" do
    @merchant = merchants(:sappy1)
    login(@merchant, :github)
    get new_product_path
    must_respond_with :success
  end

  it "should be able to successfully create a new product" do
    category_count = Product.pluck(:category).uniq
    puts "================="
    puts category_count.inspect
    puts "================="
    @merchant = merchants(:sappy1)
    login(@merchant, :github)
      proc {
        post products_path, params: { product: { name: "newbie", price: 2, category: "new category", quantity: 1, merchant_id: merchants(:sappy1).id } }
      }.must_change 'Product.count', 1
      must_respond_with :redirect
      updated_category_count = Product.pluck(:category).uniq
      updated_category_count.count.must_equal (category_count.count + 1)
    end
    it "should rerender the form and not update the review table if it can't create the review" do
      @merchant = merchants(:sappy1)
      login(@merchant, :github)
      proc {
        post products_path, params: { product: { name: "", price: 2, category: "new category", quantity: 1, merchant_id: merchants(:sappy1).id } }
      }.must_change 'Review.count', 0

      must_respond_with :redirect
    end

end
