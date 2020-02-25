class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?, :count_order_value, :notice_class, :search_placeholder

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

  def count_order_value(ebooks, basket, order_id = 0)
    full_value = ebooks.map { |e| e[:quantity] * e['price'] }.sum if basket
    full_value = ebooks.map { |e| e.ordered_quantity(order_id) * e['price'] }.sum unless basket
    discount = count_discount(ebooks, full_value)
    discount += 20 if full_value - discount >= 200

    { amount: full_value - discount, discount: discount, full_value: full_value }
  end

  def count_discount(ebooks, full_value)
    discount = 0
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

  def notice_class(name)
    name == 'notice' ? 'success' : name
  end

  def search_placeholder
    return " in #{@category.name}" if @category.present?

    ' in all categories'
  end
end
