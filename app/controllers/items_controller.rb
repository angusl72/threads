class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

  def index

    if params[:order] && params[:order] == 'Price High to Low'
      if params[:query].present?
        sql_query = "category ILIKE :query OR name ILIKE :query"
        @items = policy_scope(Item.where(sql_query, query: "%#{params[:query]}%").order(:price).reverse_order)
      else params[:query].present?
        @items = policy_scope(Item.order(:price).reverse_order)
      end
    elsif params[:order] && params[:order] == 'Price Low to High'
      if params[:query].present?
        sql_query = "category ILIKE :query OR name ILIKE :query"
        @items = policy_scope(Item.where(sql_query, query: "%#{params[:query]}%").order(:price))
      else params[:query].present?
        @items = policy_scope(Item.order(:price))
      end
    else
      if params[:query].present?
        sql_query = "category ILIKE :query OR name ILIKE :query"
        @items = policy_scope(Item.where(sql_query, query: "%#{params[:query]}%"))
      else params[:query].present?
        @items = policy_scope(Item)
      end
    end
  end

  def show
    authorize @item
  end

  def new
    @item = Item.new
    authorize @item
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    authorize @item

    if @item.save
      redirect_to @item, notice: 'Item was successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @item
  end

  def update
    authorize @item
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item), notice: "Item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @item
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path, status: :see_other, notice: "Item was successfully destroyed."
  end

  def my_items
    # skip_authorization
    # @items = policy_scope(Item)
    @items = policy_scope(Item).where(user: current_user)
    # @items = Item.all
    authorize @items

  end

  private

  def item_params
    params.require(:item).permit(:name, :type, :category, :description, :price, :size, :photo)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_booking(item)
    # raise
    # Booking.where(id: item.booking_ids).each do |item_booking_id|
    #   # raise
    #   item_booking_id.status
    # end
    if Booking.where(id: item.booking_ids).empty?
      "No current bookings"
    else
      Booking.where(id: item.booking_ids)
    end
  end
  helper_method :item_booking

end
