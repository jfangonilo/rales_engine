class Invoice < ApplicationRecord
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer
  belongs_to :merchant

  scope :from_merchant, ->(merchant_id) { where(merchant_id: merchant_id) }
  scope :created_on, ->(date) { where(created_at: date) }
end
