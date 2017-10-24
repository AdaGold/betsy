require "test_helper"

describe CategoriesController do

    describe "index" do
      # it "succeeds when there are categories" do
      #   get categories_path
      #   must_respond_with :success
      # end

      it "succeeds when there are no categories" do
        Category.all.each do |category|
          category.destroy
        end
        get categories_path
        must_respond_with :success
      end
    end

    describe "show" do
      it "can show one category" do
        get category_path(categories(:music).id)
        must_respond_with :success
      end

      it "cannot show a category that does not exist" do
        category_id = Category.last.id + 1
        get category_path(category_id)
        #add test for flash message here
        must_respond_with :redirect
        must_redirect_to root_path
      end
    end


  describe "new" do
    it "can reach a new category" do
      get new_category_path
      must_respond_with :success
    end
  end

# TODO
  describe "create" do
    it "Can create a new category" do
      proc {
        post categories_path, params: {category: {name: "socks"} }
      }.must_change 'Category.count', 1

      must_respond_with :redirect
      must_redirect_to categories_path
    end

    it "does not create a new category if a duplicate category is entered" do
      proc {
        post categories_path, params: {category: {name: "shoes"} }
      }.must_change 'Category.count', 0

      must_respond_with :success

    end
  end

  describe "edit" do
    it "should be able to successfully update a category name" do
      put category_path( categories(:shoes) ), params: { category: { name: "footwear" } }

      updated_category = Category.find( categories(:shoes).id )

      updated_category.name.must_equal "footwear"

      must_redirect_to categories_path
    end
  end

  describe "destroy" do
    it "succeeds for an extant category ID" do
      category_id = Category.first.id

      delete category_path(category_id)
      must_redirect_to categories_path

      # The category should really be gone
      Category.find_by(id: category_id).must_be_nil
    end
  end
end
