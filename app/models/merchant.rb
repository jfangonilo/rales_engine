class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

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
      .select('
        invoices.created_at as date,
        sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue
      ')
      .group('date')
      .merge(Transaction.successful)
      .where(invoices: {created_at: date})
      .order('total_revenue desc')
      .first
  end
end