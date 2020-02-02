class Transaction < ApplicationRecord
  belongs_to :invoice

  scope :successful, -> { where(result: "success") }
  scope :attached_to_customer, ->(customer_id) {
    joins(:invoice).
    where("invoices.customer_id = ?", customer_id)
  }

  scope :attached_to_invoice, ->(invoice_id) {
    joins(:invoice).
    where("invoices.id = ?", invoice_id)
  }
end
