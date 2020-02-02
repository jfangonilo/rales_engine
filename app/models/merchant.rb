class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  scope :with_name, ->(name) { where(name: name) }
  scope :from_item, ->(item_id) {
    joins(:items).
    where("items.id = ?", item_id).
    first
  }
  scope :from_invoice, ->(invoice_id) {
    joins(:invoices).
    where("invoices.id = ?", invoice_id).
    first
  }

  def self.search_all(params)
    if params[:id]
      with_id(params[:id])
    elsif params[:name]
      with_name(params[:name])
    elsif params[:created_at]
      created_on(params[:created_at])
    elsif params[:updated_at]
      updated_on(params[:updated_at])
    else
      all
    end
  end

  def self.search(params)
    if params[:id]
      find(params[:id])
    elsif params[:name]
      find_by(name: params[:name])
    elsif params[:created_at]
      find_by(created_at: params[:created_at])
    elsif params[:updated_at]
      find_by(updated_at: params[:updated_at])
    elsif params[:item_id]
      from_item(params[:item_id])
    elsif params[:invoice_id]
      from_invoice(params[:invoice_id])
    end
  end

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
    start = Time.parse(date)
    stop = start + 1.day
    Merchant.joins(invoices: [:invoice_items, :transactions])
      .select("
        date_trunc('day', invoices.created_at) as date,
        sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue
      ")
      .group('date')
      .merge(Transaction.successful)
      .where("invoices.created_at between '#{start}' and '#{stop}'")
      .order('total_revenue desc')
      .first
  end
end