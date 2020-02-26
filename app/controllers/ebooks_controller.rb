class EbooksController < ApplicationController
  before_action :require_admin, except: %i[index show add_to_basket remove_from_basket]

  def index
    @ebooks = EbooksSearch.new(query_params).call
    @categories = Category.all
  end

  def show
    @ebook = Ebook.find(params[:id])
  end

  def new
    @ebook = Ebook.new
  end

  def create
    @ebook = Ebook.new(ebook_params)
    if @ebook.save
      redirect_to root_path, notice: 'Ebook added'
    else
      render 'new'
    end
  end

  def edit
    @ebook = Ebook.find(params[:id])
  end

  def update
    @ebook = Ebook.find(params[:id])

    if @ebook.update(ebook_params)
      redirect_to root_path, notice: 'Ebook updated'
    else
      render 'edit'
    end
  end

  def destroy
    @ebook = Ebook.find(params[:id])
    if @ebook.destroy
      redirect_to root_path, notice: 'Ebook was successfully deleted'
    else
      redirect_to root_path, notice: 'Could not delete ebook'
    end
  end

  def add_to_basket
    @ebook = Ebook.find(params[:id])
    current_user.ebooks << @ebook unless has_ebook?(@ebook)

    change_ebooks_quantity(@ebook, true)
    redirect_to basket_user_path, notice: 'Item was added to basket'
  end

  def remove_from_basket
    @ebook = Ebook.find(params[:id])
    ebook_record = find_basket_ebook_record(@ebook.id)
    if ebook_record.quantity == 1
      ebook_record.destroy
    else
      change_ebooks_quantity(@ebook, false)
    end

    redirect_to basket_user_path, notice: 'Item was removed from basket'
  end

  private

  def has_ebook?(ebook)
    current_user.ebooks.include?(ebook)
  end

  def find_basket_ebook_record(ebook_id)
    UserEbook.where(user_id: current_user.id, ebook_id: ebook_id).first
  end

  def change_ebooks_quantity(ebook, increment)
    ebook_record = find_basket_ebook_record(ebook.id)
    ebook_record.quantity += increment ? 1 : -1
    ebook_record.save
  end

  def query_params
    p = params.permit(:search_query)
    { search_query: p[:search_query],
      page: params[:page],
      per_page: params[:per_page] }.compact
  end

  def ebook_params
    params.require(:ebook).permit(:title, :author, :photo_url,
                                  :abstract, :description, :price,
                                  :stock, :category_id)
  end
end
