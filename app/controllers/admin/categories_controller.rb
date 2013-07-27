class Admin::CategoriesController < ApplicationController
  before_filter :authenticate_super!

  def index
    @categories = Category.roots
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
    @parent_id = params[:parent_id]
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])

    if @category.save
      if params[:parent_id] and !params[:parent_id].empty?
        @parent_category = Category.find(params[:parent_id])
        @category.move_to_child_of(@parent_category)
      end
      redirect_to admin_categories_url
    else
      render action: "new"
    end
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(params[:category])
      redirect_to admin_categories_url
    else
      render action: "edit"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to admin_categories_url
  end
end
