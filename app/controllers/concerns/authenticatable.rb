module Authenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request!
  end

  private

  def authenticate_request!
    header = request.headers["Authorization"]
    token = header.to_s.split(" ").last

    begin
      decoded = JsonWebToken.decode(token)
      @current_athlete = Athlete.find(decoded[:athlete_id])
    rescue ActiveRecord::RecordNotFound
      render json: { meta: { message: "User not found" } }, status: :unauthorized
    rescue StandardError => e
      render json: { meta: { message: "Unauthorized", error: e.message } }, status: :unauthorized
    end
  end

  def current_athlete
    @current_athlete
  end
end
