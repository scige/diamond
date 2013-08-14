class Admin::ShopsController < ApplicationController
  before_filter :deny_to_visitors

  def index
    if super_signed_in?
      @shops = Shop.order("id DESC").page(params[:page])
    else
      @shops = Shop.where("editor='#{current_editor.email}'").order("id DESC").page(params[:page])
    end
  end

  def order_by
    @shops = Shop.order("#{params[:order]}, id DESC").page(params[:page])
    pos = params[:order].index(" DESC")
    if pos
      @column = params[:order][0...pos]
    else
      @column = params[:order]
    end

    special_columns = ["districts", "recommended_products", "description", "remarks", "created_at", "updated_at"]
    if special_columns.include?(@column)
      render "admin/shops/order_by"
    else
      render "admin/shops/index"
    end
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

    #if editor_signed_in?
    #  attributes[:editor] = current_editor.email
    #  attributes[:status] = Setting.shop.status_not_verify
    #end

    if attributes[:remarks] and !attributes[:remarks].empty?
      if !@shop.remarks or @shop.remarks.empty? or @shop.remarks != attributes[:remarks]
        if super_signed_in?
          attributes[:status] = Setting.shop.status_verify_fail
        else
          attributes[:status] = Setting.shop.status_not_verify
        end
      end
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
    if params[:editor] and !params[:editor].empty?
      @shops = Shop.where("status=#{Setting.shop.status_not_verify} and editor='#{params[:editor]}'").order("id DESC").page(params[:page])
    else
      @shops = Shop.where("status=#{Setting.shop.status_not_verify}").order("id DESC").page(params[:page])
    end
    render "admin/shops/index"
  end

  def verify_fail
    if params[:editor] and !params[:editor].empty?
      @shops = Shop.where("status=#{Setting.shop.status_verify_fail} and editor='#{params[:editor]}'").order("id DESC").page(params[:page])
    else
      @shops = Shop.where("status=#{Setting.shop.status_verify_fail}").order("id DESC").page(params[:page])
    end
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

  def have_promos
    shops = Shop.all
    @shops = []
    shops.each do |shop|
      if shop.promos.size > 0
        @shops << shop
      end
    end
    render "admin/shops/index"
  end
end
