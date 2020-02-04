class Transaction < ApplicationRecord
  belongs_to :invoice

  scope :successful, -> { where(result: "success") }
  scope :with_credit_card_number, ->(number) { where(credit_card_number: number)}
  scope :with_result, ->(result) { where(result: result)}

  scope :from_invoice, ->(invoice_id) { where(invoice_id: invoice_id).order(:id) }
  scope :from_customer, ->(customer_id) {
    joins(:invoice).
    where("invoices.customer_id = ?", customer_id)
  }

  def self.search_all(params)
    if params[:id]
      with_id(params[:id])
    elsif params[:credit_card_number]
      with_credit_card_number(params[:credit_card_number])
    elsif params[:result]
      with_result(params[:result])
    elsif params[:created_at]
      created_on(params[:created_at])
    elsif params[:updated_at]
      updated_on(params[:updated_at])
    elsif params[:customer_id]
      from_customer(params[:customer_id])
    elsif params[:invoice_id]
      from_invoice(params[:invoice_id])
    else
      all
    end
  end

  def self.search(params)
    if params[:id]
      find(params[:id])
    elsif params[:invoice_id]
      find_by(invoice_id: params[:invoice_id])
    elsif params[:credit_card_number]
      find_by(credit_card_number: params[:credit_card_number])
    elsif params[:result]
      find_by(result: params[:result])
    elsif params[:created_at]
      find_by(created_at: params[:created_at])
    elsif params[:updated_at]
      find_by(updated_at: params[:updated_at])
    end
  end
end
