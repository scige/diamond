class Admin::PromosController < ApplicationController
  before_filter :deny_to_visitors

  def index
    if super_signed_in?
      @promos = Promo.order("id DESC").page(params[:page])
    else
      @promos = Promo.where("editor='#{current_editor.email}'").order("id DESC").page(params[:page])
    end
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

    #if editor_signed_in?
    #  @promo.editor = current_editor.email
    #  @promo.status = Setting.promo.status_not_verify
    #end

    if @promo.remarks != attributes[:remarks]
      if super_signed_in?
        attributes[:status] = Setting.promo.status_verify_fail
      else
        attributes[:status] = Setting.promo.status_not_verify
      end
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

  def not_verify
    @promos = Promo.where("status=#{Setting.promo.status_not_verify} and editor='#{params[:editor]}'").order("id DESC").page(params[:page])
    render "admin/promos/index"
  end

  def verify_fail
    @promos = Promo.where("status=#{Setting.promo.status_verify_fail} and editor='#{params[:editor]}'").order("id DESC").page(params[:page])
    render "admin/promos/index"
  end
end
