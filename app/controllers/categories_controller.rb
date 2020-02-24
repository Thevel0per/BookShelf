class CategoriesController < ApplicationController
  before_action :require_admin, except: %i[show]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to root_path, notice: 'Category Created'
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to root_path, notice: 'Category updated'
    else
      render 'new'
    end
  end

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @ebooks = EbooksSearch.new(query_params(@category.id).merge(page: params[:page], per_page: params[:per_page])).call
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def query_params(category_id)
    p = params.permit(:search_query)
    { search_query: p[:search_query], category: category_id }.compact
  end
end
