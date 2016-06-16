require 'test_helper'

class StaticPageControllerTest < ActionController::TestCase
  test "should get other_charts" do
    get :other_charts
    assert_response :success
  end

  test "should get chart_js" do
    get :chart_js
    assert_response :success
  end

  test "should get morris_charts" do
    get :morris_charts
    assert_response :success
  end

  test "should get flot_charts" do
    get :flot_charts
    assert_response :success
  end

end
