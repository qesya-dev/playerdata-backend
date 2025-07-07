module Api
  module V1
    class TrainingSessionsController < ApplicationController
      include Authenticatable
      before_action :set_training_session, only: %i[show update destroy]

      # GET /training_sessions
      def index
        @training_sessions = TrainingSession.all

        render json: {
          data: @training_sessions,
          meta: {
            total: @training_sessions.count
          }
        }
      end

      # GET /training_sessions/:id
      def show
        render json: { data: @training_session }
      end

      # POST /training_sessions
      def create
        @training_session = TrainingSession.new(training_session_params)

        if @training_session.save
          render json: {
            data: @training_session,
            meta: { message: "Training session created successfully" }
          }, status: :created
        else
          render_validation_errors(@training_session)
        end
      end

      # PATCH/PUT /training_sessions/:id
      def update
        if @training_session.update(training_session_params)
          render json: {
            data: @training_session,
            meta: { message: "Training session updated successfully" }
          }
        else
          render_validation_errors(@training_session)
        end
      end

      # GET /api/v1/training_sessions/:id/leaderboard
      # GET /api/v1/training_sessions/:id/leaderboard?by=sprints
      # GET /api/v1/training_sessions/:id/leaderboard?by=top_speed
      def leaderboard
        training_session = TrainingSession.find(params[:id])
        filter_key = params[:by].presence_in(%w[distance sprints top_speed]) || "distance"

        all_metrics = training_session.session_metrics
          .includes(:athlete)
          .where.not("#{filter_key}" => nil)
          .order(created_at: :desc)

        # Keep only the latest metric per athlete
        latest_metrics_per_athlete = all_metrics.uniq { |metric| metric.athlete_id }

        sorted_leaderboard = latest_metrics_per_athlete.sort_by { |metric| -metric[filter_key].to_f }

        render json: {
          data: sorted_leaderboard.map { |metric|
            {
              athlete: metric.athlete.as_json(only: [ :id, :name, :position, :number ]),
              metric: {
                by: filter_key,
                value: metric[filter_key]
              }
            }
          },
          meta: {
            message: "Leaderboard sorted by #{filter_key}"
          }
        }
      end

      # DELETE /training_sessions/:id
      def destroy
        @training_session.destroy!
        render json: { meta: { message: "Training session deleted successfully" } }, status: :ok
      end

      private

      def set_training_session
        @training_session = TrainingSession.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { meta: { message: "Training session not found" } }, status: :not_found
      end

      def training_session_params
        params.require(:training_session).permit(:name, :date, :duration)
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
