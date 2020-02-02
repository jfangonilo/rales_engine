class Api::V1::InvoicesController < ApplicationController
  def index
    if params[:merchant_id]
      render json: InvoiceSerializer.new(Invoice.from_merchant(params[:merchant_id]))
    elsif params[:customer_id]
      render json: InvoiceSerializer.new(Invoice.from_customer(params[:customer_id]))
    else
      render json: InvoiceSerializer.new(Invoice.all)
    end

    def show
      if params[:id]
        render json: InvoiceSerializer.new(Invoice.find(params[:id]))
      end
    end
  end
end
