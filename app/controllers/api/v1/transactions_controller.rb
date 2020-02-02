class Api::V1::TransactionsController < ApplicationController
  def index
    if params[:customer_id]
      transactions = Transaction.belonging_to_customer(params[:customer_id])
      render json: TransactionSerializer.new(transactions)
    end
  end
end
