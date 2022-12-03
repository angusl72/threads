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
