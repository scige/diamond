class PromosController < ApplicationController
  layout "application_mobile"

  def show
    @promo = Promo.find_by_id(params[:id])
    @guid = params[:spm]
  end
end
