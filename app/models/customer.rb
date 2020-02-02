class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.search(params)
    if params[:id]
      find(params[:id])
    elsif params[:first_name]
      find_by(first_name: params[:first_name])
    elsif params[:last_name]
      find_by(last_name: params[:last_name])
    elsif params[:created_at]
      find_by(created_at: params[:created_at])
    elsif params[:updated_at]
      find_by(updated_at: params[:updated_at])
    end
  end
end
