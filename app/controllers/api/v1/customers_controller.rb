class Api::V1::CustomersController < ApplicationController
  def index
    render json: CustomerSerializer.new(Customer.all)
  end

  def show
    customer = Customer.search(params)
    render json: CustomerSerializer.new(customer)
  end
end