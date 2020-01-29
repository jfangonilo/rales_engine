require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq 3
  end

  it "can show a merchant" do
    db_merchant = create(:merchant)

    get "/api/v1/merchants/#{db_merchant.id}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(merchant["data"]["attributes"]["name"]).to eq db_merchant.name
  end

  it "can get a merchant's items" do
    db_merchant = create(:merchant)
    db_merchant_2 = create(:merchant)
    item_1 = create(:item, merchant: db_merchant)
    item_2 = create(:item, merchant: db_merchant)
    item_3 = create(:item, merchant: db_merchant)
    item_4 = create(:item, merchant: db_merchant_2)

    get "/api/v1/merchants/#{db_merchant.id}/items"
    expect(response).to be_successful
    items = JSON.parse(response.body)

    expect(items["data"].count).to eq 3
    items["data"].each do |item|
      expect(item["attributes"]["merchant_id"]).to eq db_merchant.id
    end
  end

  it "can get a merchant's invoices" do
    merchant = create(:merchant)
    merchant_2 = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, merchant: merchant, customer: customer)
    invoice_2 = create(:invoice, merchant: merchant, customer: customer)
    invoice_3 = create(:invoice, merchant: merchant, customer: customer)
    invoice_4 = create(:invoice, merchant: merchant_2, customer: customer)

    get "/api/v1/merchants/#{merchant.id}/invoices"
    expect(response).to be_successful
    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq 3
    invoices["data"].each do |invoice|
      expect(invoice["attributes"]["merchant_id"]).to eq merchant.id
    end
  end
end