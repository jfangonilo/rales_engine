class Api::V1::InvoicesController < ApplicationController
  def index
    if params[:id]
      render json: InvoiceSerializer.new(Invoice.with_id(params[:id]))
    elsif params[:status]
      render json: InvoiceSerializer.new(Invoice.with_status(params[:status]))
    elsif params[:created_at]
      render json: InvoiceSerializer.new(Invoice.created_on(params[:created_at]))
    elsif params[:updated_at]
      render json: InvoiceSerializer.new(Invoice.updated_on(params[:updated_at]))
    elsif params[:merchant_id]
      render json: InvoiceSerializer.new(Invoice.from_merchant(params[:merchant_id]))
    elsif params[:customer_id]
      render json: InvoiceSerializer.new(Invoice.from_customer(params[:customer_id]))
    else
      render json: InvoiceSerializer.new(Invoice.all)
    end
  end

  def show
    if params[:id]
      render json: InvoiceSerializer.new(Invoice.find(params[:id]))
    elsif params[:customer_id]
      render json: InvoiceSerializer.new(Invoice.find_by(customer_id: params[:customer_id]))
    elsif params[:merchant_id]
      render json: InvoiceSerializer.new(Invoice.find_by(merchant_id: params[:merchant_id]))
    elsif params[:status]
      render json: InvoiceSerializer.new(Invoice.find_by(status: params[:status]))
    elsif params[:created_at]
      render json: InvoiceSerializer.new(Invoice.find_by(created_at: params[:created_at]))
    elsif params[:updated_at]
      render json: InvoiceSerializer.new(Invoice.find_by(updated_at: params[:updated_at]))
    end
  end
end
