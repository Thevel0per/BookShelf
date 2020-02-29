# frozen_string_literal: true

class OrderCounter
  def count_order_value(ebooks, order_id, user_id = nil)
    @full_value = ebooks.map do |e|
      e.quantity(order_id: order_id, user_id: user_id) * e.price
    end.sum
    @discount = count_discount(ebooks, @full_value, order_id, user_id)

    {
      amount: @full_value - @discount,
      discount: @discount,
      full_value: @full_value
    }
  end

  def count_discount(ebooks, full_value, order_id, user_id = nil)
    discount = 0
    books_prices = ebooks.map do |e|
      [e.price] * e.quantity(order_id: order_id, user_id: user_id)
    end.flatten.sort
    if books_prices.size >= 5
      free_books = books_prices.size / 5
      discount += books_prices[0...free_books].sum
    end
    return discount if full_value - discount < 200

    discount + 20
  end
end
