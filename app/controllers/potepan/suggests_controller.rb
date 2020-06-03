class Potepan::SuggestsController < ApplicationController
  before_action :authenticate
  before_action :suggest_params

  def index
    keyword = params[:keyword]
    max_num = params[:max_num]
    suggests = Potepan::Suggest.where("keyword LIKE?", "#{keyword}%")
    results = suggests.limit(max_num).map { |suggest| suggest.keyword }
    render json: results
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      token == Rails.application.credentials.api[:API_SEARCH_TOKEN]
    end
  end

  def suggest_params
    params.require(:keyword)
    params.permit(:max_num)
  end
end
