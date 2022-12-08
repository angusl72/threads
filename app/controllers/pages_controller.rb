class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
  end
end



#if params[:order] && params[:order] == 'Low to high'
#  authorize @item.order(:price)
#elsif params[:order] && params[:order] == 'High to Low'
#  authorize @item.order(:price).reverse_order

=begin
if params[:order] && params[:order] == 'Low to high'
  if params[:query].present?
    sql_query = "category ILIKE :query OR name ILIKE :query"
    @items = policy_scope(Item.where(sql_query, query: "%#{params[:query]}%").order(:price))
  else params[:query].present?
    @items = policy_scope(Item.order(:price))
  end
elsif params[:order] && params[:order] == 'High to Low'
  if params[:query].present?
    sql_query = "category ILIKE :query OR name ILIKE :query"
    @items = policy_scope(Item.where(sql_query, query: "%#{params[:query]}%").order(:price).reverse_order)
  else params[:query].present?
    @items = policy_scope(Item.order(:price).reverse_order)
  end
else
  if params[:query].present?
    sql_query = "category ILIKE :query OR name ILIKE :query"
    @items = policy_scope(Item.where(sql_query, query: "%#{params[:query]}%"))
  else params[:query].present?
    @items = policy_scope(Item)
  end
=end
