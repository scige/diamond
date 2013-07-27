class Admin::DistrictsController < ApplicationController
  before_filter :authenticate_super!

  def index
    @districts = District.roots
  end

  def show
    @district = District.find(params[:id])
  end

  def new
    @district = District.new
    @parent_id = params[:parent_id]
  end

  def edit
    @district = District.find(params[:id])
  end

  def create
    @district = District.new(params[:district])

    if @district.save
      if params[:parent_id] and !params[:parent_id].empty?
        @parent_district = District.find(params[:parent_id])
        @district.move_to_child_of(@parent_district)
      end
      redirect_to admin_districts_url
    else
      render action: "new"
    end
  end

  def update
    @district = District.find(params[:id])

    if @district.update_attributes(params[:district])
      redirect_to admin_districts_url
    else
      render action: "edit"
    end
  end

  def destroy
    @district = District.find(params[:id])
    @district.destroy

    redirect_to admin_districts_url
  end
end
