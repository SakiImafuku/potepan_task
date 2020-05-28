require 'rails_helper'

RSpec.describe "SearchApis", type: :request do
  describe "GET /search_apis" do
    let!(:uri) { Rails.application.credentials.api[:API_SEARCH_URL] }

    it "正常に動作する" do
      stub_request(:get, uri).to_return(
        body: ["ruby", "ruby for women", "ruby for men", "rails", "rails for women"],
        status: 200,
      )
      get potepan_api_search_path
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json).to eq(
        "results" => ["ruby", "ruby for women", "ruby for men", "rails", "rails for women"],
        "status" => 200
      )
    end

    it 'エラー を返す' do
      stub_request(:get, uri).to_return(
        status: 500,
      )
      get potepan_api_search_path
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json).to include("status" => 500)
    end

    it 'APIが正常に機能しない場合エラー を返す' do
      get potepan_api_search_path
      expect(response).to have_http_status(500)
    end
  end
end
