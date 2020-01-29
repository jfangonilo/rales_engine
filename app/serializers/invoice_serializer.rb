class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :status

  attributes :merchant_id do |invoice|
    invoice.merchant_id
  end

  attributes :customer_id do |invoice|
    invoice.customer_id
  end
end
