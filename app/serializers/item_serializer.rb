class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :unit_price

  attributes :merchant_id do |item|
    item.merchant_id
  end

  attributes :unit_price do |item|
    item.unit_price.to_f/100
  end
end
