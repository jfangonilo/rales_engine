class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  scope :with_name, ->(name) { where(name: name) }

  def self.most_revenue(limit)
    Merchant.joins(invoices: [:invoice_items, :transactions])
      .select('
        merchants.*,
        sum(invoice_items.quantity * invoice_items.unit_price) as revenue
      ')
      .group(:id)
      .merge(Transaction.successful)
      .order('revenue desc')
      .limit(limit)
  end

  def self.total_revenue(date)
    Merchant.joins(invoices: [:invoice_items, :transactions])
      .select("
        date_trunc('day', invoices.created_at) as date,
        sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue
      ")
      .group('date')
      .merge(Transaction.successful)
      .merge(Invoice.created_on(date))
      .order('total_revenue desc')
      .first
  end
end