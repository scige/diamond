class Admin::PromosController < ApplicationController
  before_filter :deny_to_visitors

  def index
    @promos = Promo.page(params[:page])
  end

  def show
    @promo = Promo.find(params[:id])
  end

  def new
    @promo = Promo.new
    @shops = Shop.all
  end

  def edit
    @promo = Promo.find(params[:id])
    @shops = Shop.all
    #@shops = Shop.order("name")
  end

  def create
    @promo = Promo.new(params[:promo])

    if @promo.save
      redirect_to admin_promo_url(@promo)
      params[:shops].each do |shop_id|
        ShopPromoRelationship.create!(:shop_id=>shop_id, :promo_id=>@promo.id)
      end
    else
      redirect_to new_admin_promo_url
    end
  end

  def update
    @promo = Promo.find(params[:id])

    if @promo.update_attributes(params[:promo])
      @promo.shops.each do |shop|
        relations = ShopPromoRelationship.where(:shop_id=>shop.id, :promo_id=>@promo.id)
        relations.each do |relation|
          relation.destroy
        end
      end
      if params[:shops]
        params[:shops].each do |shop_id|
          ShopPromoRelationship.create!(:shop_id=>shop_id, :promo_id=>@promo.id)
        end
      end
      redirect_to admin_promo_url(@promo)
    else
      redirect_to edit_admin_promo_url(@promo)
    end
  end

  def destroy
    @promo = Promo.find(params[:id])
    @promo.destroy

    redirect_to admin_promos_url
  end
end
