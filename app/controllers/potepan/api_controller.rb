class Potepan::ApiController < ApplicationController
  def search
    url = ENV["API_SEARCH_URL"]
    token = ENV["API_SEARCH_TOKEN"]
    uri = URI.parse(url)
    http = Faraday.new(:url => "#{uri.scheme}://#{uri.host}")
    res = http.get do |req|
      req.url uri.path
      req.headers['Authorization'] = "Bearer #{token}"
      req.headers['Content-Type'] = "application/json"
      req.body = {
        keyword: params[:keyword],
        max_num: params[:MAX_NUM],
      }.to_json
    end
    render json: res.body
  end
end
