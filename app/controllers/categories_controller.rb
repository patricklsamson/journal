class CategoriesController < ApplicationController
  def index; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to @category
    else
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(:title, :details)
  end
end
