# frozen_string_literal: true

module UsersHelper
  def count_basket_value(ebooks, user_id)
    OrderCounter.new.count_order_value(ebooks, nil, user_id)
  end
end
