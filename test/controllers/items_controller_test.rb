require "test_helper"

describe ItemsController do
  describe "Index" do
    it "should get index" do
      get items_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "should be able to show an item" do
      get item_path(items(:converse_no_order).id)
      must_respond_with :success
    end

    it "Cannot show an Item that does not exist" do
      item_id = Item.last.id + 1
      get item_path(item_id)

      # must_respond_with :not_found
      must_respond_with :redirect
      must_redirect_to root_path


    end
  end

  describe "New" do
    it "should get new" do
      get new_item_path
      must_respond_with :success
    end
  end


<<<<<<< HEAD
  # TODO
  describe "Create" do
    it "Should be able to create a new item" do
      proc {
        post create_item_path, params: {item: {shipping_status: false, purchase_status: false, product_id: products[:converse].id, order_id: nil }}}.must_change 'Item.count', 1

        must_respond_with :redirect
        must_redirect_to root_path
=======
  describe "Create" do
    it "Should be able to create a new item" do

      # user = users(:carl)
      # log_in(user, :github)

      proc {
        post create_item_path(products(:converse).id) }.must_change 'Item.count', 1

      must_respond_with :redirect
      must_redirect_to root_path


>>>>>>> 3cfed66259465437ed4cd847fb98d29746334c09
    end
  end


  describe "Destroy" do
    it "Should be able to delete an item" do
      proc  {
          delete item_path(products(:converse).id)}.must_change 'Item.count', -1

          must_respond_with :redirect
          must_redirect_to root_path
    end
  end

# ---------------------------------



end
