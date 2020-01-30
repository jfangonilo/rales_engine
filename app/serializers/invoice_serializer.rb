class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :status, :merchant_id, :customer_id

  # attributes :merchant_id do |invoice|
  #   invoice.merchant_id
  # end

  # attributes :customer_id do |invoice|
  #   invoice.customer_id
  # end
end
