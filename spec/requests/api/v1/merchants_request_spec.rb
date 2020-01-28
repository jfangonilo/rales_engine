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
end