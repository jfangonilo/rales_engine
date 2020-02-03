require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "class methods" do
    it "favorite_by_merchant" do
      customer = create(:customer)

      merchant_0 = create(:merchant)
      invoice_0 = create(:invoice, customer: customer, merchant: merchant_0)
      transaction_0 = create(:transaction, invoice: invoice_0, result: "success")
      transaction_1 = create(:transaction, invoice: invoice_0, result: "success")
      transaction_2 = create(:transaction, invoice: invoice_0, result: "success")
      transaction_3 = create(:transaction, invoice: invoice_0, result: "success")
      transaction_4 = create(:transaction, invoice: invoice_0, result: "failed")

      merchant_1 = create(:merchant)
      invoice_1 = create(:invoice, customer: customer, merchant: merchant_1)
      transaction_4 = create(:transaction, invoice: invoice_1, result: "success")
      transaction_5 = create(:transaction, invoice: invoice_1, result: "success")
      transaction_6 = create(:transaction, invoice: invoice_1, result: "failed")
      transaction_7 = create(:transaction, invoice: invoice_1, result: "failed")
      transaction_8 = create(:transaction, invoice: invoice_1, result: "failed")
      transaction_9 = create(:transaction, invoice: invoice_1, result: "failed")

      merchant_2 = create(:merchant)
      invoice_2 = create(:invoice, customer: customer, merchant: merchant_2)
      transaction_10 = create(:transaction, invoice: invoice_2)
      transaction_11 = create(:transaction, invoice: invoice_2)
      transaction_12 = create(:transaction, invoice: invoice_2)

      result = Customer.favorite_by_merchant(merchant_0.id)
      expected = customer
      expect(result).to eq expected
    end
  end
end
