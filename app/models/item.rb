class Item < ApplicationRecord
  has_many :invoice_items
  belongs_to :merchant

  scope :from_merchant, ->(merchant_id) { where(merchant_id: merchant_id) }
end
