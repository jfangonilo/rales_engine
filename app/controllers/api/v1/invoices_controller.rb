class Api::V1::InvoicesController < ApplicationController
  def index
    invoices = Invoice.search_all(params)
    render json: InvoiceSerializer.new(invoices)
  end

  def show
    invoice = Invoice.search(params)
    render json: InvoiceSerializer.new(invoice)
  end
end
