class Potepan::ApiController < ApplicationController
  def search
    url = Rails.application.credentials.api[:API_SEARCH_URL]
    token = Rails.application.credentials.api[:API_SEARCH_TOKEN]

    res = Faraday.get(url) do |req|
      req.params['keyword'] = params[:keyword]
      req.params['max_num'] = SEARCH_API_MAX_NUM
      req.headers['Authorization'] = "Bearer #{token}"
      req.headers['Content-Type'] = "application/json"
    end

    if res.status == 200
      result_words = res.body
      render json: { results: result_words, status: res.status }
    else
      render json: { status: res.status }
      render status: res.status
    end
  end
end
