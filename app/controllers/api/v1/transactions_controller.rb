class Api::V1::TransactionsController < ApplicationController
  def index
    if params[:customer_id]
      transactions = Transaction.from_customer(params[:customer_id])
    elsif params[:invoice_id]
      transactions = Transaction.from_invoice(params[:invoice_id])
    else
      transactions = Transaction.all
    end
    render json: TransactionSerializer.new(transactions)
  end

  def show
    transaction = Transaction.search(params)
    render json: TransactionSerializer.new(transaction)
  end
end
