class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  scope :with_quantity, ->(quantity) { where(quantity: quantity) }
  scope :with_unit_price, ->(unit_price) { where(unit_price: unit_price) }

  scope :from_item, ->(item_id) { where(item_id: item_id).order(:id) }
  scope :from_invoice, ->(invoice_id) {
    where(invoice_id: invoice_id)
      .order(:id)
  }

  def self.search_all(params)
    if params[:id]
      with_id(params[:id])
    elsif params[:item_id]
      from_item(params[:item_id])
    elsif params[:invoice_id]
      from_invoice(params[:invoice_id])
    elsif params[:quantity]
      with_quantity(params[:quantity])
    elsif params[:unit_price]
      with_unit_price(params[:unit_price])
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
    elsif params[:item_id]
      find_by(item_id: params[:item_id])
    elsif params[:invoice_id]
      find_by(invoice_id: params[:invoice_id])
    elsif params[:quantity]
      find_by(quantity: params[:quantity])
    elsif params[:unit_price]
      find_by(unit_price: params[:unit_price])
    elsif params[:created_at]
      find_by(created_at: params[:created_at])
    elsif params[:updated_at]
      find_by(updated_at: params[:updated_at])
    end
  end
end
