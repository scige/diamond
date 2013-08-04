class Admin::ShopsController < ApplicationController
  before_filter :deny_to_visitors

  def index
    #@shops = Shop.order("editor DESC").page(params[:page])
    @shops = Shop.order("id DESC").page(params[:page])
  end

  def show
    @shop = Shop.find(params[:id])
    @product = Product.new
  end

  def new
    @shop = Shop.new
    @categories = Category.roots
    @districts = District.roots
  end

  def edit
    @shop = Shop.find(params[:id])
    @categories = Category.roots
    @districts = District.roots
  end

  def create
    @shop = Shop.new(params[:shop])
    if editor_signed_in?
      @shop.editor = current_editor.email
      @shop.status = Setting.shop.status_not_verify
    end

    if @shop.save
      redirect_to admin_shop_url(@shop)
    else
      render action: "new"
    end
  end

  def update
    @shop = Shop.find(params[:id])
    attributes = params[:shop]
    if editor_signed_in?
      attributes[:editor] = current_editor.email
      attributes[:status] = Setting.shop.status_not_verify
    end

    if @shop.update_attributes(attributes)
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
    #@shops = Shop.where("editor is not null")
    #@shops = Shop.where("status=#{Setting.shop.status_not_verify}")
    #@shops = Shop.limit(10)
  end

  def search
    @shops = Shop.where("name like '%s'" % "%#{params[:keywords]}%")
  end

  def not_verify
    @shops = Shop.where("status=#{Setting.shop.status_not_verify}").order("id DESC").page(params[:page])
    render "admin/shops/index"
  end

  def can_dingcan
    @shops = []
    shops_hash = {}
    products = Product.all
    products.each do |product|
      if shops_hash.has_key?(product.shop_id)
        shops_hash[product.shop_id] += 1
      else
        shops_hash[product.shop_id] = 1
        @shops << product.shop
      end
    end

    @shops.sort! do |a, b|
      a <=> b
    end

    render "admin/shops/index"
  end
end
