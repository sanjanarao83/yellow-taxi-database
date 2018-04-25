require 'test_helper'

class CityNamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @city_name = city_names(:one)
  end

  test "should get index" do
    get city_names_url
    assert_response :success
  end

  test "should get new" do
    get new_city_name_url
    assert_response :success
  end

  test "should create city_name" do
    assert_difference('CityName.count') do
      post city_names_url, params: { city_name: { country: @city_name.country, name: @city_name.name } }
    end

    assert_redirected_to city_name_url(CityName.last)
  end

  test "should show city_name" do
    get city_name_url(@city_name)
    assert_response :success
  end

  test "should get edit" do
    get edit_city_name_url(@city_name)
    assert_response :success
  end

  test "should update city_name" do
    patch city_name_url(@city_name), params: { city_name: { country: @city_name.country, name: @city_name.name } }
    assert_redirected_to city_name_url(@city_name)
  end

  test "should destroy city_name" do
    assert_difference('CityName.count', -1) do
      delete city_name_url(@city_name)
    end

    assert_redirected_to city_names_url
  end
end
