module Api
  module V1
    class AuthController < ApplicationController
      include Authenticatable
      skip_before_action :authenticate_request!, only: %i[signup signin refresh]

      # POST /api/v1/auth/signup
      def signup
        athlete = Athlete.new(auth_params)
        if athlete.save
          render json: { message: "Athlete created successfully" }, status: :created
        else
          render json: { errors: athlete.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # POST /api/v1/auth/signin
      def signin
        athlete = Athlete.find_by(email: params[:email])
        if athlete&.authenticate(params[:password])
          access_token = JsonWebToken.encode(athlete_id: athlete.id)
          refresh_token = SecureRandom.hex(32)
          athlete.update!(refresh_token: refresh_token)

          render json: {
            access_token: access_token,
            refresh_token: refresh_token,
            expires_in: 15.minutes.to_i,
            athlete: athlete.as_json(only: [ :id, :name, :position, :number, :email ])
          }
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end

      # POST /api/v1/auth/refresh
      def refresh
        athlete = Athlete.find_by(refresh_token: params[:refresh_token])
        if athlete
          access_token = JsonWebToken.encode(athlete_id: athlete.id)
          render json: {
            access_token: access_token,
            expires_in: 15.minutes.to_i,
            athlete: athlete.as_json(only: [ :id, :name, :position, :number, :email ])
          }
        else
          render json: { error: "Invalid refresh token" }, status: :unauthorized
        end
      end

      # POST /api/v1/auth/logout
      def logout
        if current_athlete
          current_athlete.update(refresh_token: nil)
          render json: { message: "Logged out successfully" }
        else
          render json: { error: "Not authenticated" }, status: :unauthorized
        end
      end

      private

      def auth_params
        params.permit(:name, :position, :number, :email, :password, :password_confirmation)
      end
    end
  end
end
