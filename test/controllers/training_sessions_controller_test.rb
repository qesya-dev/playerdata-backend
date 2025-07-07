require "test_helper"

class TrainingSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @training_session = training_sessions(:one)
  end

  test "should get index" do
    get training_sessions_url, as: :json
    assert_response :success
  end

  test "should create training_session" do
    assert_difference("TrainingSession.count") do
      post training_sessions_url, params: { training_session: { date: @training_session.date, duration: @training_session.duration } }, as: :json
    end

    assert_response :created
  end

  test "should show training_session" do
    get training_session_url(@training_session), as: :json
    assert_response :success
  end

  test "should update training_session" do
    patch training_session_url(@training_session), params: { training_session: { date: @training_session.date, duration: @training_session.duration } }, as: :json
    assert_response :success
  end

  test "should destroy training_session" do
    assert_difference("TrainingSession.count", -1) do
      delete training_session_url(@training_session), as: :json
    end

    assert_response :no_content
  end
end
