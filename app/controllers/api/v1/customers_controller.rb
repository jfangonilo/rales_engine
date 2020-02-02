class Api::V1::CustomersController < ApplicationController
  def index
    render json: CustomerSerializer.new(Customer.all)
  end

  def show
    if params[:id]
      render json: CustomerSerializer.new(Customer.find(params[:id]))
    elsif params[:first_name]
      render json: CustomerSerializer.new(Customer.find_by(first_name: params[:first_name]))
    elsif params[:last_name]
      render json: CustomerSerializer.new(Customer.find_by(last_name: params[:last_name]))
    end
  end
end