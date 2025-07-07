module Api
  module V1
    class AthletesController < ApplicationController
      include Authenticatable
      before_action :set_athlete, only: %i[show update destroy]

      # GET /athletes
      def index
        athletes = Athlete.all
        render_with_meta(
          data: athletes.as_json(except: [ :password_digest, :refresh_token ]),
          meta: { total: athletes.size }
        )
      end

      # GET /athletes/:id
      def show
        render_with_meta(
          data: @athlete.as_json(except: [ :password_digest, :refresh_token ]),
          meta: { requested_at: Time.current.iso8601 }
        )
      end

      # POST /athletes
      def create
        @athlete = Athlete.new(athlete_params)

        if @athlete.save
          render_with_meta(
            data: @athlete,
            meta: { message: "Athlete created successfully" },
            status: :created
          )
        else
          render_validation_errors(@athlete)
        end
      end

      # PATCH/PUT /athletes/:id
      def update
        if @athlete.update(athlete_params)
          render_with_meta(
            data: @athlete,
            meta: { message: "Athlete updated successfully" }
          )
        else
          render_validation_errors(@athlete)
        end
      end

      # DELETE /athletes/:id
      def destroy
        @athlete.destroy!
        render json: {
          meta: { message: "Athlete deleted successfully" }
        }, status: :ok
      end

      private

      def set_athlete
        @athlete = Athlete.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: {
          meta: { message: "Athlete not found" }
        }, status: :not_found
      end

      def athlete_params
        params.require(:athlete).permit(:name, :position, :number)
      end

      def render_with_meta(data:, meta: {}, status: :ok)
        render json: {
          data: data,
          meta: meta
        }, status: status
      end

      def render_validation_errors(resource)
        render json: {
          meta: { message: "Validation failed" },
          errors: resource.errors.messages
        }, status: :unprocessable_entity
      end
    end
  end
end
