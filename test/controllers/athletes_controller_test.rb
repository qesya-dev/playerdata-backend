require "test_helper"

class AthletesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @athlete = athletes(:one)
  end

  test "should get index" do
    get athletes_url, as: :json
    assert_response :success
  end

  test "should create athlete" do
    assert_difference("Athlete.count") do
      post athletes_url, params: { athlete: { name: @athlete.name, number: @athlete.number, position: @athlete.position } }, as: :json
    end

    assert_response :created
  end

  test "should show athlete" do
    get athlete_url(@athlete), as: :json
    assert_response :success
  end

  test "should update athlete" do
    patch athlete_url(@athlete), params: { athlete: { name: @athlete.name, number: @athlete.number, position: @athlete.position } }, as: :json
    assert_response :success
  end

  test "should destroy athlete" do
    assert_difference("Athlete.count", -1) do
      delete athlete_url(@athlete), as: :json
    end

    assert_response :no_content
  end
end
