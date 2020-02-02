class Transaction < ApplicationRecord
  belongs_to :invoice

  scope :successful, -> { where(result: "success") }
  scope :belonging_to_customer, ->(customer_id) {
    joins(:invoice).
    where("invoices.customer_id = ?", customer_id)
  }
end
