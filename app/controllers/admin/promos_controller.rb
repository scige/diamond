class Admin::PromosController < ApplicationController
  before_filter :authenticate_super!

  def index
    @promos = Promo.all
  end

  def show
    @promo = Promo.find(params[:id])
    @shops = Shop.all
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
      render action: "new"
    end
  end

  def update
    @promo = Promo.find(params[:id])

    if @promo.update_attributes(params[:promo])
      params[:shops].each do |shop_id|
        ShopPromoRelationship.create!(:shop_id=>shop_id, :promo_id=>@promo.id)
      end
      redirect_to admin_promo_url(@promo)
    else
      render action: "edit"
    end
  end

  def destroy
    @promo = Promo.find(params[:id])
    @promo.destroy

    redirect_to admin_promos_url
  end
end
