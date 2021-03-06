# coding: utf-8

class Admin::ProductsController < ApplicationController
  before_filter :authenticate_super!

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

  def batch_create
    @shop = Shop.find(params[:shop_id])
    if !@shop
      #render :text => "商家不存在。"
      return
    end

    raw_products = params[:attributes].strip.split("\r\n")
    raw_products.each do |rp|
      raw_product = rp.strip.split("\t")
      if raw_product.size != 2
        #数据格式错误
        return
      end
      @product = Product.new(:name=>raw_product[0], :price=>raw_product[1])
      @product.shop = @shop
      @product.save
    end
    redirect_to admin_shop_url(@shop)
  end

  def edit
    @product = Product.find(params[:id])
    @shop = Shop.find(params[:shop_id])
  end

  def update
    @product = Product.find(params[:id])
    @shop = Shop.find(params[:shop_id])
    if !@shop
      #render :text => "商家不存在。"
      return
    end

    @product.shop = @shop

    if @product.update_attributes(params[:product])
      flash[:info] = "修改商品成功。"
    else
      flash[:error] = "修改商品失败！"
    end
    redirect_to admin_shop_url(@product.shop)
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    flash[:info] = "删除商品成功。"
    redirect_to admin_shop_url(@product.shop)
  end
end
