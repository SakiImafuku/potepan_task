require 'rails_helper'

RSpec.describe "SearchApis", type: :request do
  describe "GET /search_apis" do
    let!(:uri) { Rails.application.credentials.api[:API_SEARCH_URL] }

    context "SEARCH_APIが200と共に商品名のsuggestを返した時" do
      before do
        stub_request(:get, uri).with(query: { keyword: "r", max_num: 5 }).
          to_return(
            body: ["ruby", "ruby for women", "ruby for men", "rails", "rails for women"],
            status: 200,
          )
        get potepan_api_search_path, params: {
          keyword: "r",
          max_num: 5,
        }
      end

      it "200レスポンスと共に外部APIが返した商品名のリストを返す" do
        json = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(json["results"]).
          to match_array ["ruby", "ruby for women", "ruby for men", "rails", "rails for women"]
        expect(json["status"]).to eq 200
      end
    end

    context "外部APIが500エラーを返した時" do
      before do
        stub_request(:get, uri).to_return(
          status: 500,
        )
        get potepan_api_search_path, params: {
          keyword: "r",
          max_num: 5,
        }
      end

      it '500レスポンスを返す' do
        expect(response).to have_http_status(500)
      end
    end
  end
end
