class Potepan::SuggestsController < ApplicationController
  before_action :authenticate

  def index
    keyword = params[:keyword]
    max_num = params[:max_num].to_i == 0 ? nil : params[:max_num]
    suggests = Potepan::Suggest.filter(keyword)
    results = suggests.limit(max_num).map { |suggest| suggest.keyword }

    if keyword.blank?
      render status: 500, json: "unexpected error"
    else
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
