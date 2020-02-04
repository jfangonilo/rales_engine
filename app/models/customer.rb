class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  scope :with_first_name, ->(first_name) { where(first_name: first_name) }
  scope :with_last_name, ->(last_name) { where(last_name: last_name) }

  scope :from_invoice, ->(invoice_id) {
    joins(:invoices)
      .where('invoices.id = ?', invoice_id)
      .first
  }

  def self.search_all(params)
    if params[:id]
      with_id(params[:id])
    elsif params[:first_name]
      with_first_name(params[:first_name])
    elsif params[:last_name]
      with_last_name(params[:last_name])
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
    elsif params[:first_name]
      find_by(first_name: params[:first_name])
    elsif params[:last_name]
      find_by(last_name: params[:last_name])
    elsif params[:created_at]
      find_by(created_at: params[:created_at])
    elsif params[:updated_at]
      find_by(updated_at: params[:updated_at])
    elsif params[:invoice_id]
      from_invoice(params[:invoice_id])
    end
  end

  def self.favorite_by_merchant(merchant_id)
    joins(invoices: [:transactions])
      .select("
        customers.*,
        count(transactions.id) as total_successful_transactions
      ")
      .group(:id)
      .merge(Transaction.successful)
      .where(invoices: { merchant_id: merchant_id })
      .order('total_successful_transactions desc')
      .limit(1)
      .first
  end
end
