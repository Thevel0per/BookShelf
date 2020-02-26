class OrdersController < ApplicationController
  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def create
    @order = Order.new(user_id: current_user.id).paginate(page: params[:page], per_page: 5)
    @ebooks = ordered_ebooks
    if available?(@ebooks)
      @order.save
      create_order_ebooks(@ebooks, @order.id)
      clear_basket
      redirect_to root_path, notice: 'Order has been placed'
    else
      redirect_to basket_user_path, notice: availability_error_message(@ebooks)
    end
  end
e
  def show

  end

  private

  def ordered_ebooks
    Ebook.joins(:user_ebooks).where(user_ebooks: { user_id: current_user.id })
  end

  def available?(ebooks)
    ebooks.all? { |ebook| ebook.stock >= ebook.quantity(current_user.id) }
  end

  def availability_error_message(ebooks)
    message = "Order couldn't be made, you have tried to order: "
    ebooks.each do |e|
      stock = e.available
      quantity = ebooks.quantity(current_user.id)
      message += "#{quantity}x '#{e.title}',only #{stock} available " if stock < quantity
    end
    message
  end

  def create_order_ebooks(ebooks, order_id)
    ebooks.each do |e|
      quantity = e.quantity(current_user.id)
      oe = OrderEbook.new(ebook_id: e.id, order_id: order_id, quantity: quantity)
      if oe.save
        e.stock -= quantity
        e.save
      end
    end
  end

  def clear_basket
    UserEbook.where(user_id: current_user.id).each do |e|
      e.destroy
    end
  end
end
