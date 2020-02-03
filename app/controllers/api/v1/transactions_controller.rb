class Api::V1::TransactionsController < ApplicationController
  def index
    if params[:id]
      transactions = Transaction.with_id(params[:id])
    elsif params[:credit_card_number]
      transactions = Transaction.with_credit_card_number(params[:credit_card_number])
    elsif params[:result]
      transactions = Transaction.with_result(params[:result])
    elsif params[:created_at]
      transactions = Transaction.created_on(params[:created_at])
    elsif params[:updated_at]
      transactions = Transaction.updated_on(params[:updated_at])
    elsif params[:customer_id]
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
