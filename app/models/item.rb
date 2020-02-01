class Item < ApplicationRecord
  has_many :invoice_items
  belongs_to :merchant

  scope :with_name, ->(name) { where(name: name) }
  scope :from_merchant, ->(merchant_id) { where(merchant_id: merchant_id) }
  scope :with_description, ->(description) { where(description: description) }
  scope :with_unit_price, ->(unit_price) { where(unit_price: unit_price) }
end
