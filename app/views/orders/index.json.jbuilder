json.array!(@orders) do |order|
  json.extract! order, :id, :user_id, :address, :status, :comment, :fio, :phone
  json.url order_url(order, format: :json)
end
