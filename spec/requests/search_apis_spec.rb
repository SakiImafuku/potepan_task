require 'rails_helper'

RSpec.describe "SearchApis", type: :request do
  describe "GET /search_apis" do
    it "works! (now write some real specs)" do
      get potepan_api_search_path, params: {
        keyword: "r",
        max_num: 5,
      }
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json).to eq(["ruby", "ruby for women", "ruby for men", "rails", "rails for women"])
    end
  end
end
