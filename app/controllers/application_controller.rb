class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?, :count_basket_value

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    return if logged_in?

    flash[:danger] = 'You must be logged in to perform that action'
    redirect_to login_path
  end

  def require_admin
    return if logged_in? && current_user.admin?

    flash[:danger] = 'Only admins can perform that action'
    redirect_to root_path
  end

  def count_basket_value(ebooks)
    full_value = ebooks.map { |e| e[:quantity] * e['price'] }.sum
    discount = count_discount(ebooks, full_value)

    { amount: full_value - discount, discount: discount, full_value: full_value }
  end

  def count_discount(ebooks, full_value)
    discount = 0
    discount += 20 if full_value >= 200
    books_prices = []
    ebooks.each do |e|
      (1..e[:quantity]).each do |_|
        books_prices << e['price']
      end
    end
    books_prices.sort
    if books_prices.size >= 5
      free_books = books_prices.size / 5
      discount += books_prices[0...free_books].sum
    end
    discount
  end
end
