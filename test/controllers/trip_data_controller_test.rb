require 'test_helper'

class TripDataControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trip_datum = trip_data(:one)
  end

  test "should get index" do
    get trip_data_url
    assert_response :success
  end

  test "should get new" do
    get new_trip_datum_url
    assert_response :success
  end

  test "should create trip_datum" do
    assert_difference('TripDatum.count') do
      post trip_data_url, params: { trip_datum: { dropoff_datetime: @trip_datum.dropoff_datetime, passenger_count: @trip_datum.passenger_count, pickup_datetime: @trip_datum.pickup_datetime, recordid: @trip_datum.recordid, store_and_fwd_flag: @trip_datum.store_and_fwd_flag, trip_distance: @trip_datum.trip_distance, vendorid: @trip_datum.vendorid } }
    end

    assert_redirected_to trip_datum_url(TripDatum.last)
  end

  test "should show trip_datum" do
    get trip_datum_url(@trip_datum)
    assert_response :success
  end

  test "should get edit" do
    get edit_trip_datum_url(@trip_datum)
    assert_response :success
  end

  test "should update trip_datum" do
    patch trip_datum_url(@trip_datum), params: { trip_datum: { dropoff_datetime: @trip_datum.dropoff_datetime, passenger_count: @trip_datum.passenger_count, pickup_datetime: @trip_datum.pickup_datetime, recordid: @trip_datum.recordid, store_and_fwd_flag: @trip_datum.store_and_fwd_flag, trip_distance: @trip_datum.trip_distance, vendorid: @trip_datum.vendorid } }
    assert_redirected_to trip_datum_url(@trip_datum)
  end

  test "should destroy trip_datum" do
    assert_difference('TripDatum.count', -1) do
      delete trip_datum_url(@trip_datum)
    end

    assert_redirected_to trip_data_url
  end
end
