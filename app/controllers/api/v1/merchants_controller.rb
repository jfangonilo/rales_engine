class Api::V1::MerchantsController < ApplicationController
  def index
    elsif params[:quantity]
      render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity].to_i))
    else
      render json: MerchantSerializer.new(Merchant.all)
    end
  end

  def show
    if params[:id]
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    elsif params[:name]
      render json: MerchantSerializer.new(Merchant.find_by(name: params[:name]))
    elsif params[:created_at]
      render json: MerchantSerializer.new(Merchant.find_by(created_at: params[:created_at]))
    elsif params[:updated_at]
      render json: MerchantSerializer.new(Merchant.find_by(updated_at: params[:updated_at]))
    end
  end
end