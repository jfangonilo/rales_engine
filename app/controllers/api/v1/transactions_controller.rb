class Api::V1::TransactionsController < ApplicationController
  def index
    transactions = Transaction.search_all(params)
    render json: TransactionSerializer.new(transactions)
  end

  def show
    transaction = Transaction.search(params)
    render json: TransactionSerializer.new(transaction)
  end
end
