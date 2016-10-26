$('#current_order').html("<%= escape_javascript refresh(@current_order) %>");
$(document).trigger "order:update"
alert "товар << <%=j @product.title%> >> добавлен в корзину."