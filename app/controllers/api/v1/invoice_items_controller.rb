class Api::V1::InvoiceItemsController < ApplicationController
  def index
    if params[:item_id]
      invoice_items = InvoiceItem.from_item(params[:item_id])
    elsif params[:invoice_id]
      invoice_items = InvoiceItem.from_invoice(params[:invoice_id])
    end
    render json: InvoiceItemSerializer.new(invoice_items)
  end
end