class Transaction < ApplicationRecord
  belongs_to :invoice

  scope :successful, -> { where(result: "success") }
  scope :from_invoice, ->(invoice_id) { where(invoice_id: invoice_id) }
  scope :from_customer, ->(customer_id) {
    joins(:invoice).
    where("invoices.customer_id = ?", customer_id)
  }

end
