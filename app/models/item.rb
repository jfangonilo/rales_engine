class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  scope :with_name, ->(name) { where(name: name) }
  scope :with_description, ->(description) { where(description: description) }
  scope :with_unit_price, ->(unit_price) { where(unit_price: unit_price) }

  scope :from_merchant, ->(merchant_id) { where(merchant_id: merchant_id) }
  scope :from_invoice, ->(invoice_id) {
    joins(:invoices).
    where("invoices.id = ?", invoice_id)
  }
  scope :from_invoice_item, ->(invoice_item_id) {
    joins(:invoice_items).
    where("invoice_items.id = ?", invoice_item_id).
    first
  }

  def self.search_all(params)
    if params[:id]
      with_id(params[:id])
    elsif params[:name]
      with_name(params[:name])
    elsif params[:description]
      with_description(params[:description])
    elsif params[:unit_price]
      with_unit_price(params[:unit_price])
    elsif params[:created_at]
      created_on(params[:created_at])
    elsif params[:updated_at]
      updated_on(params[:updated_at])
    elsif params[:merchant_id]
      from_merchant(params[:merchant_id])
    elsif params[:invoice_id]
      from_invoice(params[:invoice_id])
    elsif params[:quantity]
      most_revenue(params[:quantity])
    else
      all
    end
  end

  def self.search(params)
    if params[:id]
      find(params[:id])
    elsif params[:name]
      find_by(name: params[:name])
    elsif params[:description]
      find_by(description: params[:description])
    elsif params[:unit_price]
      find_by(unit_price: params[:unit_price])
    elsif params[:merchant_id]
      find_by(merchant_id: params[:merchant_id])
    elsif params[:created_at]
      find_by(created_at: params[:created_at])
    elsif params[:updated_at]
      find_by(updated_at: params[:updated_at])
    elsif params[:invoice_item_id]
      from_invoice_item(params[:invoice_item_id])
    end
  end

  def self.most_revenue(limit)
    joins(invoice_items: [invoice: [:transactions]]).
    select("items.*,
      sum(invoice_items.quantity * invoice_items.unit_price) as revenue
    ").
    group(:id).
    merge(Transaction.successful).
    order('revenue desc').
    limit(limit)
  end
end
