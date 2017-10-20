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

  describe "create" do
    it "creates a product with valid data for a real category" do
      proc {
        post categories_path, params: {category: {name: "bandanas"} }
      }.must_change 'Category.count', 1

      must_respond_with :redirect
      must_redirect_to categories_path

    end



  end


end
