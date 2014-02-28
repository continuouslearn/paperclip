json.array!(@myusers) do |myuser|
  json.extract! myuser, :id, :uname
  json.url myuser_url(myuser, format: :json)
end
