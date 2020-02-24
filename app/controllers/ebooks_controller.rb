class EbooksController < ApplicationController
  def index
    @ebooks = EbooksSearch.new(query_params.merge(page: params[:page], per_page: params[:per_page])).call
    @categories = Category.all
  end

  def show

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

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
    { search_query: p[:search_query] }.compact
  end
end
