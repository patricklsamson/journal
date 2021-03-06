class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @categories = Category.where(user_id: current_user.id) if user_signed_in?
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    @category.update(user_id: current_user.id)

    if @category.save
      redirect_to @category
    else
      render :new
    end
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to @category
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to categories_url
  end

  private

  def category_params
    params.require(:category).permit(:title, :details, :user_id)
  end
end
