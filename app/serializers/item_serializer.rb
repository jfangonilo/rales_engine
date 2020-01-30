class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description

  attributes :merchant_id do |item|
    item.merchant_id
  end

  attributes :unit_price do |item|
    item.unit_price.to_s
  end
end
