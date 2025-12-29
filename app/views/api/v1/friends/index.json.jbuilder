json.meta do
  json.total @friends.count
end

json.data do
  json.array! @friends do |friend|
    json.id friend.id
    json.first_name friend.first_name
    json.last_name friend.last_name
    json.email friend.email
    json.user_id friend.user_id
  end
end


