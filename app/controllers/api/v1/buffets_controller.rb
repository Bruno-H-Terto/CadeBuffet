class Api::V1::BuffetsController < ActionController::API
  def index
    buffets = Buffet.all
    render status: 200, json: buffets
  end
end