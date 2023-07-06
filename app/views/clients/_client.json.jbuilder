json.extract! client, :id, :phone, :name, :email, :user_id, :created_at, :updated_at
json.url client_url(client, format: :json)
