class Api::V1::InvoicesController < ApplicationController
  def index
    if params[:merchant_id]
      render json: InvoiceSerializer.new(Invoice.from_merchant(params[:merchant_id]))
    end
  end
end
