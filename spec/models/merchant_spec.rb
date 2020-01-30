require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
    it { should have_many :invoices }
  end

  describe 'class methods' do
    before :each do
      @customer = create(:customer)
      @merchants = create_list(:merchant, 7)

      @item_0 = create(:item, merchant: @merchants[0], unit_price: 1)
      @item_1 = create(:item, merchant: @merchants[1], unit_price: 10)
      @item_2 = create(:item, merchant: @merchants[2], unit_price: 100)
      @item_3 = create(:item, merchant: @merchants[3], unit_price: 1000)
      @item_4 = create(:item, merchant: @merchants[4], unit_price: 10000)
      @item_5 = create(:item, merchant: @merchants[5], unit_price: 100000)
      @item_6 = create(:item, merchant: @merchants[6], unit_price: 1000000)

      @date = "2020-01-01"
      @invoice_0 = create(:invoice, customer: @customer, merchant: @merchants[0], created_at: @date)
      @invoice_1 = create(:invoice, customer: @customer, merchant: @merchants[1], created_at: @date)
      @invoice_2 = create(:invoice, customer: @customer, merchant: @merchants[2], created_at: @date)
      @invoice_3 = create(:invoice, customer: @customer, merchant: @merchants[3], created_at: @date)
      @invoice_4 = create(:invoice, customer: @customer, merchant: @merchants[4])
      @invoice_5 = create(:invoice, customer: @customer, merchant: @merchants[5], created_at: @date)
      @invoice_6 = create(:invoice, customer: @customer, merchant: @merchants[6], created_at: @date)

      @invoice_item_0 = create(:invoice_item, item: @item_0, unit_price: @item_0.unit_price, invoice: @invoice_0)
      @invoice_item_1 = create(:invoice_item, item: @item_1, unit_price: @item_1.unit_price, invoice: @invoice_1)
      @invoice_item_2 = create(:invoice_item, item: @item_2, unit_price: @item_2.unit_price, invoice: @invoice_2)
      @invoice_item_3 = create(:invoice_item, item: @item_3, unit_price: @item_3.unit_price, invoice: @invoice_3)
      @invoice_item_4 = create(:invoice_item, item: @item_4, unit_price: @item_4.unit_price, invoice: @invoice_4)
      @invoice_item_5 = create(:invoice_item, item: @item_5, unit_price: @item_5.unit_price, invoice: @invoice_5)
      @invoice_item_6 = create(:invoice_item, item: @item_6, unit_price: @item_6.unit_price, invoice: @invoice_6)

      @transaction_0 = create(:transaction, invoice: @invoice_0)
      @transaction_1 = create(:transaction, invoice: @invoice_1)
      @transaction_2 = create(:transaction, invoice: @invoice_2)
      @transaction_3 = create(:transaction, invoice: @invoice_3)
      @transaction_4 = create(:transaction, invoice: @invoice_4)
      @transaction_5 = create(:transaction, invoice: @invoice_5, result: "failed")
      @transaction_6 = create(:transaction, invoice: @invoice_6, result: "failed")
    end

    it 'most_revenue' do
      expected = [@merchants[4], @merchants[3], @merchants[2]]
      expect(Merchant.most_revenue(3)).to eq expected
    end

    it 'total_revenue_by_date' do
      result = Merchant.total_revenue(@date)
      expected = 1111
      expect(result.total_revenue).to eq expected
    end
  end
end
