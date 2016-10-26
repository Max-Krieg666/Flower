$ ->
  $(document).on 'order:update', ->
    $.ajax
      url: '/orders.js'
      method: 'GET'
      dataType: 'html'
      success: (data)->
        $("#order_info").html(data)