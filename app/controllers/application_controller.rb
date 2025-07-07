class ApplicationController < ActionController::API
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :handle_parse_error
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from ActionController::ParameterMissing, with: :handle_missing_params
  rescue_from ActiveRecord::RecordInvalid, with: :handle_unprocessable_entity

  private

  def handle_parse_error(exception)
    render json: { error: "Invalid JSON format", message: exception.message }, status: :bad_request
  end

  def handle_not_found(exception)
    render json: { error: "Not Found", message: exception.message }, status: :not_found
  end

  def handle_missing_params(exception)
    render json: { error: "Missing parameter", message: exception.message }, status: :bad_request
  end

  def handle_unprocessable_entity(exception)
    render json: { error: "Validation failed", message: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
