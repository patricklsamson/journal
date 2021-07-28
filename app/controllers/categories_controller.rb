class CategoriesController < ApplicationController
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

  def update; end

  private

  def category_params
    params.require(:category).permit(:title, :details)
  end
end
