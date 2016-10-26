json.array!(@users) do |user|
  json.extract! user, :id, :email, :phone_number, :address, :role
  json.url user_url(user, format: :json)
end
