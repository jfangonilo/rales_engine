class Api::V1::TransactionsController < ApplicationController
  def index
    if params[:customer_id]
      transactions = Transaction.attached_to_customer(params[:customer_id])
    elsif params[:invoice_id]
      transactions = Transaction.attached_to_invoice(params[:invoice_id])
    end
    render json: TransactionSerializer.new(transactions)
  end
end
