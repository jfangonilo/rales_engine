class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  scope :from_item, ->(item_id) { where(item_id: item_id) }
  scope :from_invoice, ->(invoice_id) {
    joins(:invoice).
    where("invoices.id = ?", invoice_id)
  }
end
