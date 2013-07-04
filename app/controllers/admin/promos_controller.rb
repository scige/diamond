class Admin::PromosController < ApplicationController
  before_filter :authenticate_super!

  def index
    @promos = Promo.all
  end

  def show
    @promo = Promo.find(params[:id])
  end

  def new
    @promo = Promo.new
  end

  def edit
    @promo = Promo.find(params[:id])
  end

  def create
    @promo = Promo.new(params[:promo])

    if @promo.save
      redirect_to admin_promo_url(@promo)
    else
      render action: "new"
    end
  end

  def update
    @promo = Promo.find(params[:id])

    if @promo.update_attributes(params[:promo])
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
