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

  it "can find a merchant by id" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant.id}"
    expect(response).to be_successful
    parsed_merchant = JSON.parse(response.body)
    expect(parsed_merchant["data"]["attributes"]["id"]).to eq merchant.id
  end

  it "can find a merchant by name" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name}"
    expect(response).to be_successful
    parsed_merchant = JSON.parse(response.body)
    expect(parsed_merchant["data"]["attributes"]["id"]).to eq merchant.id
  end

  it "can find a merchant by created_at date" do
    merchant = create(:merchant, created_at: Time.now.to_s)

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"
    expect(response).to be_successful
    parsed_merchant = JSON.parse(response.body)
    expect(parsed_merchant["data"]["attributes"]["id"]).to eq merchant.id
  end

  it "can find a merchant by updated_at date" do
    merchant = create(:merchant, updated_at: Time.now.to_s)

    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"
    expect(response).to be_successful
    parsed_merchant = JSON.parse(response.body)
    expect(parsed_merchant["data"]["attributes"]["id"]).to eq merchant.id
  end

  it "can find all merchants with a given id" do
    merchant = create(:merchant)
    merchant_2 = create(:merchant)

    get "/api/v1/merchants/find_all?id=#{merchant.id}"
    expect(response).to be_successful
    parsed_merchants = JSON.parse(response.body)
    expect(parsed_merchants["data"].count).to eq 1
    expect(parsed_merchants["data"][0]["attributes"]["id"]).to eq merchant.id
  end

  it "can find all merchants with a certain name" do
    merchant = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant, name: "other name")

    expect(merchant.name).to eq merchant_2.name
    get "/api/v1/merchants/find_all?name=#{merchant.name}"
    expect(response).to be_successful
    parsed_merchants = JSON.parse(response.body)
    expect(parsed_merchants["data"].count).to eq 2
    expect(parsed_merchants["data"][0]["attributes"]["name"]).to eq merchant.name
    expect(parsed_merchants["data"][1]["attributes"]["name"]).to eq merchant_2.name
  end

  it "can find all merchants created on a certain date" do
    date = "2012-01-01"
    merchant = create(:merchant, created_at: date)
    merchant_2 = create(:merchant, created_at: date)
    merchant_3 = create(:merchant, created_at: "2020-01-01")

    get "/api/v1/merchants/find_all?created_at=#{date}"
    expect(response).to be_successful
    parsed_merchants = JSON.parse(response.body)
    expect(parsed_merchants["data"].count).to eq 2
    expect(parsed_merchants["data"][0]["attributes"]["name"]).to eq merchant.name
    expect(parsed_merchants["data"][1]["attributes"]["name"]).to eq merchant_2.name
  end

  it "can find all merchants updated on a certain date" do
    date = "2012-01-01"
    merchant = create(:merchant, updated_at: date)
    merchant_2 = create(:merchant, updated_at: date)
    merchant_3 = create(:merchant, updated_at: "2020-01-01")

    get "/api/v1/merchants/find_all?updated_at=#{date}"
    expect(response).to be_successful
    parsed_merchants = JSON.parse(response.body)
    expect(parsed_merchants["data"].count).to eq 2
    expect(parsed_merchants["data"][0]["attributes"]["name"]).to eq merchant.name
    expect(parsed_merchants["data"][1]["attributes"]["name"]).to eq merchant_2.name
  end

  it "can return merchants by most revenue" do
    merchant = create(:merchant)
    customer = create(:customer)

    item = create(:item, merchant: merchant, unit_price: 100)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item = create(:invoice_item, item: item, unit_price: item.unit_price, invoice: invoice)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/merchants/most_revenue?quantity=1"
    expect(response).to be_successful
    parsed_merchants = JSON.parse(response.body)
    expect(parsed_merchants["data"][0]["attributes"]["id"]).to eq merchant.id
  end

  it "can get revenue for merchants by date" do
    merchant = create(:merchant)
    customer = create(:customer)

    date = "2012-01-01"
    item = create(:item, merchant: merchant, unit_price: 100)
    invoice = create(:invoice, customer: customer, merchant: merchant, created_at: date)
    invoice_item = create(:invoice_item, item: item, unit_price: item.unit_price, invoice: invoice)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/merchants/revenue?date=#{date}"
    expect(response).to be_successful
    result = JSON.parse(response.body)
    expect(result["data"]["attributes"]["total_revenue"]).to eq "100.0"
  end

  it "can get favorite customer for a merchant" do
    merchant = create(:merchant)

    customer_0 = create(:customer)
    invoice_0 = create(:invoice, customer: customer_0, merchant: merchant)
    transaction_0 = create(:transaction, invoice: invoice_0, result: "success")
    transaction_1 = create(:transaction, invoice: invoice_0, result: "success")
    transaction_2 = create(:transaction, invoice: invoice_0, result: "success")
    transaction_3 = create(:transaction, invoice: invoice_0, result: "success")
    transaction_4 = create(:transaction, invoice: invoice_0, result: "failed")

    customer_1 = create(:customer)
    invoice_1 = create(:invoice, customer: customer_1, merchant: merchant)
    transaction_4 = create(:transaction, invoice: invoice_1, result: "success")
    transaction_5 = create(:transaction, invoice: invoice_1, result: "success")
    transaction_6 = create(:transaction, invoice: invoice_1, result: "failed")
    transaction_7 = create(:transaction, invoice: invoice_1, result: "failed")
    transaction_8 = create(:transaction, invoice: invoice_1, result: "failed")
    transaction_9 = create(:transaction, invoice: invoice_1, result: "failed")

    customer_2 = create(:customer)
    invoice_2 = create(:invoice, customer: customer_2, merchant: merchant)
    transaction_10 = create(:transaction, invoice: invoice_2)
    transaction_11 = create(:transaction, invoice: invoice_2)
    transaction_12 = create(:transaction, invoice: invoice_2)

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result["attributes"]["id"]).to eq customer_0.id
    expect(result["attributes"]["first_name"]).to eq customer_0.first_name
    expect(result["attributes"]["last_name"]).to eq customer_0.last_name
  end
end