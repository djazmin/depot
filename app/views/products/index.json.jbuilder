json.array!(@products) do |product|
  json.extract! product, :title, :description, :image, :price
  json.url product_url(product, format: :json)
end
