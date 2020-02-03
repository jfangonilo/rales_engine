require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should have_many :invoice_items }
    it { should belong_to :merchant }
  end

  describe "class methods" do
    before :each do
      @customer = create(:customer)
      @merchant = create(:merchant)

      @item_0 = create(:item, merchant: @merchant, unit_price: 1)
      @item_1 = create(:item, merchant: @merchant, unit_price: 10)
      @item_2 = create(:item, merchant: @merchant, unit_price: 100)
      @item_3 = create(:item, merchant: @merchant, unit_price: 1_000)
      @item_4 = create(:item, merchant: @merchant, unit_price: 10_000)
      @item_5 = create(:item, merchant: @merchant, unit_price: 100_000)
      @item_6 = create(:item, merchant: @merchant, unit_price: 1_000_000_000)

      @invoice_0 = create(:invoice, customer: @customer, merchant: @merchant)
      @invoice_item_0 = create(:invoice_item, quantity: 1_000_000, item: @item_0, invoice: @invoice_0, unit_price: @item_0.unit_price)
      @invoice_item_1 = create(:invoice_item, quantity: 1_000_000, item: @item_1, invoice: @invoice_0, unit_price: @item_1.unit_price)
      @invoice_item_2 = create(:invoice_item, quantity: 1_000, item: @item_2, invoice: @invoice_0, unit_price: @item_2.unit_price)

      @invoice_1 = create(:invoice, customer: @customer, merchant: @merchant)
      @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_1, unit_price: @item_2.unit_price)
      @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice_1, unit_price: @item_3.unit_price)
      @invoice_item_4 = create(:invoice_item, item: @item_4, invoice: @invoice_1, unit_price: @item_4.unit_price)
      @invoice_item_5 = create(:invoice_item, item: @item_5, invoice: @invoice_1, unit_price: @item_5.unit_price)
      @invoice_item_6 = create(:invoice_item, item: @item_6, invoice: @invoice_1, unit_price: @item_6.unit_price)

      @transaction_0 = create(:transaction, invoice: @invoice_0)
      @transaction_1 = create(:transaction, invoice: @invoice_1, result: "failed")
    end

    it 'most revenue' do
      expected = [@item_1, @item_0]
      result = Item.most_revenue(2)
      expect(result).to eq expected
    end
  end
end
