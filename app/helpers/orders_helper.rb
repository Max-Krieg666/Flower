module OrdersHelper
  def select_user(user, selected = nil)
    select_tag(user, options_for_select(
                       User.order('email').load.map{ |x| [x.email, x.id] } + [['', nil]],
                       [selected]))
  end

  def select_status(status, selected = nil)
    select_tag(status, options_for_select([['Оформлен', 1], ['Подтверждён', 2],
                                           ['Отменён', 3], ['Доставляется', 4],
                                           ['Завершён', 5]]))
  end

  def show_order(order)
    render 'orders/init_order', order: order
    text = "В корзине #{order.total_line_items} #{Russian.p(order.total_line_items, 'товар', 'товара', 'товаров')} на сумму #{number_to_currency(order.total_amount)}"
    content_tag(:div, text, class: 'alert alert-danger', id: 'current_order')
  end

  def refresh(order)
    "В корзине #{order.total_line_items} #{Russian.p(order.total_line_items,'товар','товара','товаров')} на сумму #{number_to_currency(order.total_amount)}"
  end
end