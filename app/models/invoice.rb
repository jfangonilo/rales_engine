class Invoice < ApplicationRecord
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer
  belongs_to :merchant

  scope :with_status, ->(status) { where(status: status) }

  scope :from_merchant, ->(merchant_id) { where(merchant_id: merchant_id) }
  scope :from_customer, ->(customer_id) { where(customer_id: customer_id).order(:id) }
  scope :from_invoice_item, ->(invoice_item_id) {
    joins(:invoice_items).
    where("invoice_items.id = ?", invoice_item_id).
    first
  }
  scope :from_transaction, ->(transaction_id) {
    joins(:transactions).
    where("transactions.id = ?", transaction_id).
    first
  }

  def self.search_all(params)
    if params[:id]
      with_id(params[:id])
    elsif params[:status]
      with_status(params[:status])
    elsif params[:created_at]
      created_on(params[:created_at])
    elsif params[:updated_at]
      updated_on(params[:updated_at])
    elsif params[:merchant_id]
      from_merchant(params[:merchant_id])
    elsif params[:customer_id]
      from_customer(params[:customer_id])
    else
      all
    end
  end

  def self.search(params)
    if params[:id]
      find(params[:id])
    elsif params[:customer_id]
      find_by(customer_id: params[:customer_id])
    elsif params[:merchant_id]
      find_by(merchant_id: params[:merchant_id])
    elsif params[:status]
      find_by(status: params[:status])
    elsif params[:created_at]
      find_by(created_at: params[:created_at])
    elsif params[:updated_at]
      find_by(updated_at: params[:updated_at])
    elsif params[:invoice_item_id]
      from_invoice_item(params[:invoice_item_id])
    elsif params[:transaction_id]
      from_transaction(params[:transaction_id])
    end
  end
end
