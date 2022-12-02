class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

  def index
    @items = policy_scope(Item)
  end

  def show
    authorize @item
  end

  def new

    @item = Item.new
    authorize @item
  end

  def create
    authorize @item
    @item = Item.new(item_params)
    @item.user = current_user
  end

  def edit
    authorize @item
  end

  def update
    authorize @item
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to item_path(@item)
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path, status: :see_other
  end

  private

  def item_params
    params.require(:item).permit(:name, :type, :description, :price, :size)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
