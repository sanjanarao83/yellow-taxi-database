require "application_system_test_case"

class CityNamesTest < ApplicationSystemTestCase
  setup do
    @city_name = city_names(:one)
  end

  test "visiting the index" do
    visit city_names_url
    assert_selector "h1", text: "City Names"
  end

  test "creating a City name" do
    visit city_names_url
    click_on "New City Name"

    fill_in "Country", with: @city_name.country
    fill_in "Name", with: @city_name.name
    click_on "Create City name"

    assert_text "City name was successfully created"
    click_on "Back"
  end

  test "updating a City name" do
    visit city_names_url
    click_on "Edit", match: :first

    fill_in "Country", with: @city_name.country
    fill_in "Name", with: @city_name.name
    click_on "Update City name"

    assert_text "City name was successfully updated"
    click_on "Back"
  end

  test "destroying a City name" do
    visit city_names_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "City name was successfully destroyed"
  end
end
