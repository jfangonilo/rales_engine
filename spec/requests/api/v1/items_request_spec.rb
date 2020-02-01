require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant: merchant)

    get '/api/v1/items'

    expect(response).to be_successful
    items = JSON.parse(response.body)
    expect(items["data"].count).to eq 3
  end

  it "can show an item" do
    merchant = create(:merchant)
    db_item = create(:item, merchant: merchant)

    get "/api/v1/items/#{db_item.id}"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["name"]).to eq db_item.name
  end

  it "find an item by id" do
    merchant = create(:merchant)

    item = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)

    get "/api/v1/items/find?id=#{item.id}"

    expect(response).to be_successful
    parsed_item = JSON.parse(response.body)["data"]
    expect(parsed_item["attributes"]["id"]).to eq item.id
    expect(parsed_item["attributes"]["name"]).to eq item.name
  end

  it "find an item by name" do
    merchant = create(:merchant)

    item = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)

    get "/api/v1/items/find?name=#{item.name}"

    expect(response).to be_successful
    parsed_item = JSON.parse(response.body)["data"]
    expect(parsed_item["attributes"]["id"]).to eq item.id
    expect(parsed_item["attributes"]["name"]).to eq item.name
  end

  it "finds an item by description" do
    merchant = create(:merchant)

    item = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)

    get "/api/v1/items/find?description=#{item.description}"
    expect(response).to be_successful
    parsed_item = JSON.parse(response.body)["data"]
    expect(parsed_item["attributes"]["id"]).to eq item.id
    expect(parsed_item["attributes"]["name"]).to eq item.name
  end

  it "finds an item by merchant_id" do
    merchant = create(:merchant)
    merchant_2 = create(:merchant)

    item = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant_2)

    get "/api/v1/items/find?merchant_id=#{item.merchant_id}"
    expect(response).to be_successful
    parsed_item = JSON.parse(response.body)["data"]
    expect(parsed_item["attributes"]["id"]).to eq item.id
    expect(parsed_item["attributes"]["name"]).to eq item.name
  end

  it "finds an item by unit_price" do
    merchant = create(:merchant)

    item = create(:item, merchant: merchant)
    item_2 = create(:item, unit_price: 2, merchant: merchant)

    get "/api/v1/items/find?unit_price=#{item_2.unit_price}"
    expect(response).to be_successful
    parsed_item = JSON.parse(response.body)["data"]
    expect(parsed_item["attributes"]["id"]).to eq item_2.id
    expect(parsed_item["attributes"]["name"]).to eq item_2.name
  end

  it "finds an item by created_at" do
    date = "2012-01-01"
    merchant = create(:merchant)

    item = create(:item, merchant: merchant, created_at: date)
    item_2 = create(:item, merchant: merchant)

    get "/api/v1/items/find?created_at=#{date}"
    expect(response).to be_successful
    parsed_item = JSON.parse(response.body)["data"]
    expect(parsed_item["attributes"]["id"]).to eq item.id
    expect(parsed_item["attributes"]["name"]).to eq item.name
  end

  it "finds an item by updated_at" do
    date = "2012-01-01"
    merchant = create(:merchant)

    item = create(:item, merchant: merchant, updated_at: date)
    item_2 = create(:item, merchant: merchant)

    get "/api/v1/items/find?updated_at=#{date}"
    expect(response).to be_successful
    parsed_item = JSON.parse(response.body)["data"]
    expect(parsed_item["attributes"]["id"]).to eq item.id
    expect(parsed_item["attributes"]["name"]).to eq item.name
  end

  it "finds all items with an id" do
    merchant = create(:merchant)

    item = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)

    get "/api/v1/items/find_all?id=#{item.id}"
    expect(response).to be_successful
    parsed_items = JSON.parse(response.body)["data"]
    expect(parsed_items.first["attributes"]["id"]).to eq item.id
    expect(parsed_items.first["attributes"]["name"]).to eq item.name
  end

  it "finds all items with name" do
    merchant = create(:merchant)

    item = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    item_3 = create(:item, merchant: merchant, name: "not the same")

    get "/api/v1/items/find_all?name=#{item.name}"
    expect(response).to be_successful
    parsed_items = JSON.parse(response.body)["data"]
    expect(parsed_items.count).to eq 2
    expect(parsed_items.first["attributes"]["id"]).to eq item.id
    expect(parsed_items.first["attributes"]["name"]).to eq item.name
    expect(parsed_items.last["attributes"]["id"]).to eq item_2.id
    expect(parsed_items.last["attributes"]["name"]).to eq item_2.name
  end

  it "finds all items with name" do
    merchant = create(:merchant)

    item = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    item_3 = create(:item, merchant: merchant, name: "not the same")

    get "/api/v1/items/find_all?name=#{item.name}"
    expect(response).to be_successful
    parsed_items = JSON.parse(response.body)["data"]
    expect(parsed_items.count).to eq 2
    expect(parsed_items.first["attributes"]["id"]).to eq item.id
    expect(parsed_items.first["attributes"]["name"]).to eq item.name
    expect(parsed_items.last["attributes"]["id"]).to eq item_2.id
    expect(parsed_items.last["attributes"]["name"]).to eq item_2.name
  end

  it "finds all items with description" do
    merchant = create(:merchant)

    item = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    item_3 = create(:item, merchant: merchant, description: "not the same")

    get "/api/v1/items/find_all?description=#{item.description}"
    expect(response).to be_successful
    parsed_items = JSON.parse(response.body)["data"]
    expect(parsed_items.count).to eq 2
    expect(parsed_items.first["attributes"]["id"]).to eq item.id
    expect(parsed_items.first["attributes"]["name"]).to eq item.name
    expect(parsed_items.last["attributes"]["id"]).to eq item_2.id
    expect(parsed_items.last["attributes"]["name"]).to eq item_2.name
  end

  it "finds all items with unit_price" do
    merchant = create(:merchant)

    item = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    item_3 = create(:item, merchant: merchant, unit_price: 1000)

    get "/api/v1/items/find_all?unit_price=#{item.unit_price}"
    expect(response).to be_successful
    parsed_items = JSON.parse(response.body)["data"]
    expect(parsed_items.count).to eq 2
    expect(parsed_items.first["attributes"]["id"]).to eq item.id
    expect(parsed_items.first["attributes"]["name"]).to eq item.name
    expect(parsed_items.last["attributes"]["id"]).to eq item_2.id
    expect(parsed_items.last["attributes"]["name"]).to eq item_2.name
  end

  it "finds all items with merchant" do
    merchant = create(:merchant)
    merchant_2 = create(:merchant)

    item = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    item_3 = create(:item, merchant: merchant_2)

    get "/api/v1/items/find_all?merchant_id=#{item.merchant_id}"
    expect(response).to be_successful
    parsed_items = JSON.parse(response.body)["data"]
    expect(parsed_items.count).to eq 2
    expect(parsed_items.first["attributes"]["id"]).to eq item.id
    expect(parsed_items.first["attributes"]["name"]).to eq item.name
    expect(parsed_items.last["attributes"]["id"]).to eq item_2.id
    expect(parsed_items.last["attributes"]["name"]).to eq item_2.name
  end

  it "finds all items with created_at" do
    merchant = create(:merchant)

    date = "2012-01-01"
    item = create(:item, merchant: merchant, created_at: date)
    item_2 = create(:item, merchant: merchant, created_at: date)
    item_3 = create(:item, merchant: merchant)

    get "/api/v1/items/find_all?created_at=#{date}"
    expect(response).to be_successful
    parsed_items = JSON.parse(response.body)["data"]
    expect(parsed_items.count).to eq 2
    expect(parsed_items.first["attributes"]["id"]).to eq item.id
    expect(parsed_items.first["attributes"]["name"]).to eq item.name
    expect(parsed_items.last["attributes"]["id"]).to eq item_2.id
    expect(parsed_items.last["attributes"]["name"]).to eq item_2.name
  end

  it "finds all items with updated_at" do
    merchant = create(:merchant)

    date = "2012-01-01"
    item = create(:item, merchant: merchant, updated_at: date)
    item_2 = create(:item, merchant: merchant, updated_at: date)
    item_3 = create(:item, merchant: merchant)

    get "/api/v1/items/find_all?updated_at=#{date}"
    expect(response).to be_successful
    parsed_items = JSON.parse(response.body)["data"]
    expect(parsed_items.count).to eq 2
    expect(parsed_items.first["attributes"]["id"]).to eq item.id
    expect(parsed_items.first["attributes"]["name"]).to eq item.name
    expect(parsed_items.last["attributes"]["id"]).to eq item_2.id
    expect(parsed_items.last["attributes"]["name"]).to eq item_2.name
  end

  it "finds all associated invoice_items" do
    merchant = create(:merchant)
    customer = create(:customer)

    item = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    invoice_item = create(:invoice_item, item: item, invoice: invoice)
    invoice_item_2 = create(:invoice_item, item: item, invoice: invoice)
    invoice_item_3 = create(:invoice_item, item: item, invoice: invoice)
    invoice_item_4 = create(:invoice_item, item: item_2, invoice: invoice)

    get "/api/v1/items/#{item.id}/invoice_items"
    expect(response).to be_successful
    parsed_invoice_items = JSON.parse(response.body)["data"]
    expect(parsed_invoice_items.count).to eq 3
  end

  it "finds the associated merchant" do
    merchant = create(:merchant)

    item = create(:item, merchant: merchant)
    get "/api/v1/items/#{item.id}/merchant"
    expect(response).to be_successful
    parsed_merchant = JSON.parse(response.body)["data"]
    binding.pry
    expect(parsed_merchant["attributes"]["id"]).to eq merchant.id
  end
end