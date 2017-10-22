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
      get products_path, params: {categories: one.categories}
      must_respond_with :success
      #valid merchant
      get products_path, params: {merchant: one.merchant.id}
      must_respond_with :success
      #valid category and merchant
      get products_path, params: {categories: one.categories, merchant: one.merchant.id}
      must_respond_with :success
    end

    it "must respond with a 404 (400?) if any filter parameters are invalid" do
      skip
    end
  end

  describe "show" do
    it "must get the show view" do
      get product_path(one.id)
      must_respond_with :success

      get product_path(-1)
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  describe "new product" do
    it "should get new if a mercant is signed in" do
      @merchant = merchants(:sappy1)
      login(@merchant, :github)
      get new_product_path
      must_respond_with :success
    end

    it "must redirect to root path if a merchant is not signed in" do
      # With no mercant signed in
      get edit_product_path(one.id)
      must_respond_with :redirect
      flash[:status].must_equal :error
      must_redirect_to root_path
    end
  end

  describe "create product" do
    before do
      @merchant = merchants(:sappy1)
      login(@merchant, :github)
    end

    it "should be able to successfully create a new product" do
        proc {
          post products_path, params: { name: "newbie", price: 2, category: "new category", quantity: 1, merchant_id: @merchant.id }
        }.must_change 'Product.count', 1
      must_respond_with :redirect
    end

    it "should not create the product if it is missing a name" do
      proc {
        post products_path, params: { name: "", price: 2, category: "new category", quantity: 1, merchant_id: merchants(:sappy1).id }
      }.must_change 'Product.count', 0

      must_respond_with :redirect
      flash[:status].must_equal :error
    end

    it "should not create the product if it is missing a price" do
      proc {
        post products_path, params: { name: "Name", category: "new category", quantity: 1, merchant_id: merchants(:sappy1).id }
      }.must_change 'Product.count', 0

      must_respond_with :redirect
      flash[:status].must_equal :error
    end

    #Need to test other non-validated values or is it covered enough in the model??
  end

  describe "edit" do

    let(:one) {products(:tree1)}
    let(:two) {products(:tree2)}

    it "must redirect to root path if there is no product" do
      @merchant = merchants(:sappy1)
      login(@merchant, :github)

      get edit_product_path(-1)
      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "must redirect to root path if the merchant of the product is not signed in" do
      # With no mercant signed in
      get edit_product_path(one.id)
      must_respond_with :redirect
      must_redirect_to root_path

      #With an invalid merchant signed in
      invalid_merchant = merchants(:sappy2)
      login(invalid_merchant, :github)

      get edit_product_path(one.id)
      flash[:status].must_equal :error
      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "must show edit view if the merchant is logged in and there is a product" do
      @merchant = merchants(:sappy1)
      login(@merchant, :github)

      get edit_product_path(one.id)
      must_respond_with :success
    end
  end

  describe "update a product with a valid merchant signed in" do
      let(:merchant1) {merchants(:sappy1)}
      let(:one) {products(:tree1)}

    before do
      login(merchant1, :github)
    end

    it "successfully updates the categories of the product when selected" do
      session[:merchant_id].to_i.must_equal merchant1.id

      #format passed through params if chosen from a list
      before = one.categories.count
      puts before

      patch product_path(one.id), params:{ categories: ["outdoor"]}

      test_product = Product.find_by(id: one.id)

      test_product.categories.length.must_equal (before + 1)
      test_product.categories.must_include "outdoor"
    end

    it "sucessfully updates the categories of a product when written" do
      #format passed through params if typed in
      before = one.categories.count
      patch product_path(one.id), params:{ category: "Birthday"}

      test_product = Product.find_by(id: one.id)

      test_product.categories.count.must_equal (before + 1)
      test_product.categories.must_include "Birthday"
    end

    it "successfully updates the categories when passed in both written and selected" do
      before = one.categories.count
      patch product_path(one.id), params:{ category: "Birthday", categories: ["outdoor"] }

      test_product = Product.find_by(id: one.id)

      test_product.categories.count.must_equal (before + 2)
    end

    it "updates all categories available if the merchant writes in" do
      Product.categories.include?("Birthday").must_equal false
      patch product_path(one.id), params:{ category: "Birthday"}

      Product.categories.include?("Birthday").must_equal true
    end

    it "successfully updates the title, price, and quantity of the product" do
      login(merchant1, :github)

      patch product_path(one.id), params:{ name: "New Tree", price: 5.0, quantity: 15 }

      test_product = Product.find_by(id: one.id)

      test_product.name.must_equal "New Tree"
      test_product.price.must_equal 5.0
      test_product.quantity.must_equal 15

      flash[:status].must_equal :success
      must_redirect_to product_path(one.id)
    end

    it "must return succes and redirect to root_path if saved" do
      login(merchant1, :github)

      session[:merchant_id].to_i.must_equal merchant1.id

      patch product_path(one.id), params:{ categories: ["outdoor"]}

      flash[:status].must_equal :success
      must_redirect_to product_path(one.id)
    end

    describe "will not update" do
      let(:merchant2) {merchants(:sappy2)}
      let(:one) {products(:tree1)}

      it "will redirect if the product is invalid" do
        patch product_path(-1), params: { categories: ["Birthday"] }
        flash[:status].must_equal :error
        flash[:result_text].must_equal "That is not a valid product"
        must_redirect_to root_path
      end

      it "will redirect if the merchant of the product is not signed in" do
        #Invalid merchant is signed in
        login(merchant2, :github)

        patch product_path(one.id), params:{categories: ["Birthday"]}
        flash[:status].must_equal :error
        must_redirect_to root_path

        #no merchant signed in
        logout_path
        categories = one.categories

        patch product_path(one.id), params:{categories: ["Birthday"]}
        flash[:status].must_equal :error
        must_redirect_to root_path
      end

      it "will not update an invalid attribute" do
        login(merchants(:sappy1), :github)

        patch product_path(one.id), params:{price: "hello"}

        test_product = Product.find_by(id: one.id)

        test_product.name.must_equal "Tree1"
        flash[:status].must_equal :error
        must_redirect_to edit_product_path(one.id)
      end
    end
  end
end
