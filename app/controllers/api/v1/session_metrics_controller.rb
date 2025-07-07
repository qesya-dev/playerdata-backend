module Api
  module V1
    class SessionMetricsController < ApplicationController
      include Authenticatable

      before_action :set_training_session, except: [ :by_athlete ]
      before_action :set_session_metric, only: %i[show update destroy]

      # GET /training_sessions/:training_session_id/session_metrics
      def index
        @session_metrics = @training_session.session_metrics.includes(:athlete)

        render json: {
          data: @session_metrics.map { |metric|
            serialize_metric_with_athlete_and_training(metric)
          },
          meta: {
            message: "List of session metrics with athlete and training session details"
          }
        }
      end

      # GET /training_sessions/:training_session_id/session_metrics/:id
      def show
        render json: {
          data: serialize_metric_with_athlete_and_training(@session_metric),
          meta: {
            message: "Session metric details with athlete and training session"
          }
        }
      end

      # POST /training_sessions/:training_session_id/session_metrics
      def create
        @session_metric = @training_session.session_metrics.build(session_metric_params)

        if @session_metric.save
          render json: {
            data: @session_metric,
            meta: {
              message: "Session metric created successfully"
            }
          }, status: :created
        else
          render_validation_errors(@session_metric)
        end
      end

      # PATCH/PUT /training_sessions/:training_session_id/session_metrics/:id
      def update
        if @session_metric.update(session_metric_params)
          render json: {
            data: @session_metric,
            meta: {
              message: "Session metric updated successfully"
            }
          }
        else
          render_validation_errors(@session_metric)
        end
      end

      # DELETE /training_sessions/:training_session_id/session_metrics/:id
      def destroy
        @session_metric.destroy!
        render json: {
          meta: {
            message: "Session metric deleted successfully"
          }
        }, status: :ok
      end

      # GET /session_metrics/by_athlete/:athlete_id
      def by_athlete
        athlete = Athlete.find(params[:athlete_id])
        session_metrics = athlete.session_metrics.includes(:training_session)

        render json: {
          data: session_metrics.map { |metric| serialize_metric_with_athlete_and_training(metric) },
          meta: {
            message: "Session metrics for athlete #{athlete.name}",
            total: session_metrics.size
          }
        }
      rescue ActiveRecord::RecordNotFound
        render json: {
          meta: { message: "Athlete not found" }
        }, status: :not_found
      end

      private

      def set_training_session
        @training_session = TrainingSession.find(params[:training_session_id])
      rescue ActiveRecord::RecordNotFound
        render json: {
          meta: {
            message: "Training session not found"
          }
        }, status: :not_found
      end

      def set_session_metric
        @session_metric = @training_session.session_metrics.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: {
          meta: {
            message: "Session metric not found"
          }
        }, status: :not_found
      end

      def session_metric_params
        params.require(:session_metric).permit(:athlete_id, :distance, :sprints, :top_speed)
      end

      def serialize_metric_with_athlete_and_training(metric)
        {
          id: metric.id,
          distance: metric.distance,
          sprints: metric.sprints,
          top_speed: metric.top_speed,
          created_at: metric.created_at,
          updated_at: metric.updated_at,
          athlete: metric.athlete.as_json(only: [ :id, :name, :position, :number ]),
          training_session: metric.training_session.as_json(only: [ :id, :name, :date, :duration ])
        }
      end

      def render_validation_errors(resource)
        render json: {
          meta: {
            message: "Validation failed"
          },
          errors: resource.errors.messages
        }, status: :unprocessable_entity
      end
    end
  end
end
