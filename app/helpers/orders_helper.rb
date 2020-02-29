# frozen_string_literal: true

module OrdersHelper
  def count_order_value(ebooks, order_id)
    OrderCounter.new.count_order_value(ebooks, order_id)
  end
end
