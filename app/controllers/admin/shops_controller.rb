class Admin::ShopsController < ApplicationController
  before_filter :deny_to_visitors

  def index
    @shops = Shop.page(params[:page])
  end

  def show
    @shop = Shop.find(params[:id])
  end

  def new
    @shop = Shop.new
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def create
    @shop = Shop.new(params[:shop])

    if @shop.save
      redirect_to admin_shop_url(@shop)
    else
      render action: "new"
    end
  end

  def update
    @shop = Shop.find(params[:id])

    if @shop.update_attributes(params[:shop])
      redirect_to admin_shop_url(@shop)
    else
      render action: "edit"
    end
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy

    redirect_to admin_shops_url
  end

  def map
    @shops = Shop.all
    #@shops = Shop.limit(10)
  end
end
