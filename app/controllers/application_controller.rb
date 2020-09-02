class ApplicationController < ActionController::API
  include Exceptions

  rescue_from ActiveRecord::RecordNotFound,    with: :not_found_request
  rescue_from ActiveRecord::RecordInvalid,     with: :four_twenty_two_request
  rescue_from Exceptions::AuthenticationError, with: :unauthorized_request
  rescue_from Exceptions::MissingToken,        with: :four_twenty_two_request
  rescue_from Exceptions::InvalidToken,        with: :four_twenty_two_request

  private

  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def not_found_request(error)
    json_response({ message: error.message }, :not_found)
  end

  def four_twenty_two_request(error)
    json_response({ message: error.message }, :unprocessable_entity)
  end

  def unauthorized_request(error)
    json_response({ message: error.message }, :unauthorized)
  end
end
