require 'rails_helper'

describe "InvoiceItems API" do
  it "sends a list of invoice_items" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    item = create(:item, merchant: merchant)
    invoice_item = create_list(:invoice_item, 3, invoice: invoice, item: item)

    get "/api/v1/invoice_items"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result.count).to eq 3
  end

  it "can show an invoice_item" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    item = create(:item, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item)

    get "/api/v1/invoice_items/#{invoice_item.id}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result["attributes"]["id"]).to eq invoice_item.id
  end

  it "can find an invoice_item by id" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    item = create(:item, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item)

    get "/api/v1/invoice_items/find?id=#{invoice_item.id}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result["attributes"]["id"]).to eq invoice_item.id
  end

  it "can find an invoice_item by item_id" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    item = create(:item, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item)

    get "/api/v1/invoice_items/find?item_id=#{invoice_item.item_id}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result["attributes"]["id"]).to eq invoice_item.id
  end

  it "can find an invoice_item by invoice_id" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    item = create(:item, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item)

    get "/api/v1/invoice_items/find?invoice_id=#{invoice_item.invoice_id}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result["attributes"]["id"]).to eq invoice_item.id
  end

  it "can find an invoice_item by quantity" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    item = create(:item, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item)

    get "/api/v1/invoice_items/find?quantity=#{invoice_item.quantity}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result["attributes"]["id"]).to eq invoice_item.id
  end

  it "can find an invoice_item by unit_price" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    item = create(:item, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item)

    get "/api/v1/invoice_items/find?unit_price=#{invoice_item.unit_price}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result["attributes"]["id"]).to eq invoice_item.id
  end

  it "can find an invoice_item by created_at" do
    date = "2012-01-01"
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    item = create(:item, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item, created_at: date)

    get "/api/v1/invoice_items/find?created_at=#{invoice_item.created_at}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result["attributes"]["id"]).to eq invoice_item.id
  end

  it "can find an invoice_item by updated_at" do
    date = "2012-01-01"
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    item = create(:item, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item, updated_at: date)

    get "/api/v1/invoice_items/find?updated_at=#{invoice_item.updated_at}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result["attributes"]["id"]).to eq invoice_item.id
  end

  it "can find all invoice_items by id" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant)
    invoice_3 = create(:invoice, customer: customer, merchant: merchant)
    item = create(:item, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item)
    invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item)
    invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item)

    get "/api/v1/invoice_items/find_all?id=#{invoice_item.id}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result.first["attributes"]["id"]).to eq invoice_item.id
  end

  it "can find all invoice_items by item_id" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant)
    invoice_3 = create(:invoice, customer: customer, merchant: merchant)
    item = create(:item, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item)
    invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item)
    invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item)

    get "/api/v1/invoice_items/find_all?item_id=#{invoice_item.item_id}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result.count).to eq 3
    expect(result.first["attributes"]["item_id"]).to eq invoice_item.item_id
  end

  it "can find all invoice_items by invoice_id" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant)
    invoice_3 = create(:invoice, customer: customer, merchant: merchant)
    item = create(:item, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item)
    invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item)
    invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item)

    get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_item.invoice_id}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result.count).to eq 1
    expect(result.first["attributes"]["invoice_id"]).to eq invoice_item.invoice_id
  end

  it "can find all invoice_items by quantity" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant)
    invoice_3 = create(:invoice, customer: customer, merchant: merchant)
    item = create(:item, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item)
    invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item)
    invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item)

    get "/api/v1/invoice_items/find_all?quantity=#{invoice_item.quantity}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result.count).to eq 3
    expect(result.first["attributes"]["quantity"]).to eq invoice_item.quantity
  end

  it "can find all invoice_items by unit_price" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant)
    invoice_3 = create(:invoice, customer: customer, merchant: merchant)
    item = create(:item, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item)
    invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item)
    invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item)

    get "/api/v1/invoice_items/find_all?unit_price=#{invoice_item.unit_price}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result.count).to eq 3
    expect(result.first["attributes"]["unit_price"]).to eq invoice_item.unit_price.to_s
  end

  it "can find all invoice_items by created_at" do
    date = "2012-01-01"
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant)
    invoice_3 = create(:invoice, customer: customer, merchant: merchant)
    item = create(:item, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item, created_at: date)
    invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item, created_at: date)
    invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item, created_at: date)

    get "/api/v1/invoice_items/find_all?created_at=#{invoice_item.created_at}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result.count).to eq 3
  end

  it "can find all invoice_items by updated_at" do
    date = "2012-01-01"
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant)
    invoice_3 = create(:invoice, customer: customer, merchant: merchant)
    item = create(:item, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item, updated_at: date)
    invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item, updated_at: date)
    invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item, updated_at: date)

    get "/api/v1/invoice_items/find_all?updated_at=#{invoice_item.updated_at}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result.count).to eq 3
  end

  it "can return the associated item" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    item = create(:item, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result["attributes"]["id"]).to eq item.id
  end

  it "can return the associated invoice" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    item = create(:item, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result["attributes"]["id"]).to eq invoice.id
  end
end