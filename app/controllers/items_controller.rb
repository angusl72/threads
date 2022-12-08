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
    @item_reviews = @item.item_reviews
    @seller_reviews = @item.seller_reviews

    @average_item_rating = @item_reviews.average(:rating).round()
    @average_seller_rating = @seller_reviews.average(:rating).round()
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

  private

  def item_params
    params.require(:item).permit(:name, :type, :category, :description, :price, :size, :photo)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
