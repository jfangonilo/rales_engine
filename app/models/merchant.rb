class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.most_revenue(limit)
    Merchant.joins(invoices: [:invoice_items, :transactions])
      .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
      .group(:id)
      .where(transactions: {result: 'success'})
      .order('revenue desc')
      .limit(limit)
  end
end
