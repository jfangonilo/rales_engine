class Api::V1::TransactionsController < ApplicationController
  def index
    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      render json: TransactionSerializer.new(customer.transactions)
    end
  end
end
