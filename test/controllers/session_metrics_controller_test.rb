require "test_helper"

class SessionMetricsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @session_metric = session_metrics(:one)
  end

  test "should get index" do
    get session_metrics_url, as: :json
    assert_response :success
  end

  test "should create session_metric" do
    assert_difference("SessionMetric.count") do
      post session_metrics_url, params: { session_metric: { athlete_id: @session_metric.athlete_id, distance: @session_metric.distance, sprints: @session_metric.sprints, top_speed: @session_metric.top_speed, training_session_id: @session_metric.training_session_id } }, as: :json
    end

    assert_response :created
  end

  test "should show session_metric" do
    get session_metric_url(@session_metric), as: :json
    assert_response :success
  end

  test "should update session_metric" do
    patch session_metric_url(@session_metric), params: { session_metric: { athlete_id: @session_metric.athlete_id, distance: @session_metric.distance, sprints: @session_metric.sprints, top_speed: @session_metric.top_speed, training_session_id: @session_metric.training_session_id } }, as: :json
    assert_response :success
  end

  test "should destroy session_metric" do
    assert_difference("SessionMetric.count", -1) do
      delete session_metric_url(@session_metric), as: :json
    end

    assert_response :no_content
  end
end
