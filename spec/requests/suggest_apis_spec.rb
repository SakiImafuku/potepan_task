require 'rails_helper'

RSpec.describe "SuggestApis", type: :request do
  describe "GET /potepan_suggests" do
    let!(:keyword_s_1)  { create(:suggest, keyword: 'shirts') }
    let!(:keyword_r_1)  { create(:suggest, keyword: 'ruby') }
    let!(:keyword_r_2)  { create(:suggest, keyword: 'ruby for women') }
    let!(:keyword_r_3)  { create(:suggest, keyword: 'ruby for men') }
    let!(:keyword_r_4)  { create(:suggest, keyword: 'rails') }
    let!(:keyword_r_5)  { create(:suggest, keyword: 'rails for women') }
    let!(:keyword_r_6)  { create(:suggest, keyword: 'rails for men') }
    let!(:token)        { Rails.application.credentials.api[:API_SEARCH_TOKEN] }

    context "keywordがある場合" do
      before do
        get potepan_suggests_path, params: {
          keyword: "r",
          max_num: 5,
        }, headers: {
          'Authorization' => "Bearer #{token}",
        }
      end

      it 'キーワードに一致するものを５つ返す' do
        json = JSON.parse(response.body)
        expect(json).to eq ["ruby", "ruby for women", "ruby for men", "rails", "rails for women"]
      end

      it 'キーワードと一致しないものは返さない' do
        json = JSON.parse(response.body)
        expect(json).not_to include(keyword_s_1.keyword)
      end

      it 'max_numを超えるキーワードは返さない' do
        json = JSON.parse(response.body)
        expect(json).not_to include(keyword_r_6.keyword)
      end
    end

    context "max_numに数字以外が指定されている場合" do
      before do
        get potepan_suggests_path, params: {
          keyword: "r",
          max_num: "a",
        }, headers: {
          'Authorization' => "Bearer #{token}",
        }
      end

      it "キーワードに一致するものをすべて返す" do
        json = JSON.parse(response.body)
        expect(json).to include(keyword_r_6.keyword)
      end
    end

    context "keywordがない場合" do
      before do
        get potepan_suggests_path, params: {
          max_num: 5,
        }, headers: {
          'Authorization' => "Bearer #{token}",
        }
      end

      it "エラーを返す" do
        expect(response).to have_http_status(500)
        expect(response.body).to eq "unexpected error"
      end
    end

    context "Authorizationが一致しない場合" do
      before do
        get potepan_suggests_path, params: {
          max_num: 5,
        }, headers: {
          'Authorization' => "Bearer abc",
        }
      end

      it "エラーを返す" do
        expect(response).to have_http_status(401)
        expect(response.body).to eq "HTTP Token: Access denied.\n"
      end
    end
  end
end
