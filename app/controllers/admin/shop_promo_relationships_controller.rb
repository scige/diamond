class Admin::ShopPromoRelationshipsController < ApplicationController
  before_filter :authenticate_super!

  def index
    @shop_promo_relationships = ShopPromoRelationship.order("shop_id").order("promo_id")
  end

  def show
    @shop_promo_relationship = ShopPromoRelationship.find(params[:id])
  end

  def new
    @shop_promo_relationship = ShopPromoRelationship.new
  end

  def edit
    @shop_promo_relationship = ShopPromoRelationship.find(params[:id])
  end

  def create
    @shop_promo_relationship = ShopPromoRelationship.new(params[:shop_promo_relationship])

    if @shop_promo_relationship.save
      redirect_to admin_shop_promo_relationship_url(@shop_promo_relationship)
    else
      render action: "new"
    end
  end

  def update
    @shop_promo_relationship = ShopPromoRelationship.find(params[:id])

    if @shop_promo_relationship.update_attributes(params[:shop_promo_relationship])
      redirect_to admin_shop_promo_relationship_url(@shop_promo_relationship)
    else
      render action: "edit"
    end
  end

  def destroy
    @shop_promo_relationship = ShopPromoRelationship.find(params[:id])
    @shop_promo_relationship.destroy

    redirect_to admin_shop_promo_relationships_url
  end
end
