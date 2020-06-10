class Potepan::SuggestsController < ApplicationController
  before_action :authenticate

  def index
    keyword = params[:keyword]
    max_num = params[:max_num].to_i == 0 ? nil : params[:max_num]

    if keyword.blank?
      render status: 404, json: "error: missing keyword"
    else
      results = Potepan::Suggest.filter(keyword, max_num).pluck(:keyword)
      render status: 200, json: results
    end
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      token == Rails.application.credentials.api[:API_SEARCH_TOKEN]
    end
  end
end
