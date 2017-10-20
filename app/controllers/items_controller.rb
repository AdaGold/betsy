class ItemsController < ApplicationController
  def index
    @item = Item.order(:id)
  end


  def show
    @item = Item.find_by(id: params[:id])
    # puts params[:id]

    # render_404 unless @item

    unless @item
      flash[:error] = "Item not found"
      redirect_to root_path
    end
  end


  def new
    item = Item.new
  end



  def create
    @item = Item.new item_params

    if @item.save
      puts "success"
      flash[:success] = "Item added successfully"
      redirect_to root_path
    else
      puts @item.errors.full_messages
      flash.now[:error] = "Item not added"
      render :new
    end
  end


  # def edit
  # end
  #
  #
  # def update
  # end

  def destroy
    @item = Item.find_by(id: params[:id].to_i)

    @item.destroy

    redirect_to root_path
  end

  private

  def item_params
    return params.require(:item).permit(:shipping_status, :purchase_status, :product_id, :order_id)
  end

end
