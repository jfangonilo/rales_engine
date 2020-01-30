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
end