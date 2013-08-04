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
    @shops = Shop.order("id DESC")
  end

  def edit
    @promo = Promo.find(params[:id])
    @shops = Shop.order("id DESC")
  end

  def create
    @promo = Promo.new(params[:promo])
    if editor_signed_in?
      @promo.editor = current_editor.email
      @promo.status = Setting.promo.status_not_verify
    end

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
    attributes = params[:promo]
    if editor_signed_in?
      attributes[:editor] = current_editor.email
      attributes[:status] = Setting.promo.status_not_verify
    end

    if @promo.update_attributes(attributes)
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
