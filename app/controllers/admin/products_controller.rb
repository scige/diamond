# coding: utf-8

class Admin::ProductsController < ApplicationController
  before_filter :authenticate_super!

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(params[:product])
    @shop = Shop.find(params[:shop_id])
    if !@shop
      #render :text => "商家不存在。"
      return
    end

    @product.shop = @shop

    if @product.save
      flash[:info] = "创建商品成功。"
    else
      flash[:error] = "创建商品失败！"
    end
    redirect_to admin_shop_url(@product.shop)
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      redirect_to admin_product_url(@product)
    else
      render action: "edit"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to admin_products_url
  end
end
