require "application_system_test_case"

class StocksTest < ApplicationSystemTestCase
  setup do
    @stock = stocks(:one)
  end

  test "visiting the index" do
    visit stocks_url
    assert_selector "h1", text: "Stocks"
  end

  test "creating a Stock" do
    visit stocks_url
    click_on "New Stock"

    fill_in "Channel", with: @stock.channel_id
    fill_in "Item", with: @stock.item_id
    fill_in "Level", with: @stock.level
    fill_in "Location", with: @stock.location_id
    fill_in "Product", with: @stock.product_id
    click_on "Create Stock"

    assert_text "Stock was successfully created"
    click_on "Back"
  end

  test "updating a Stock" do
    visit stocks_url
    click_on "Edit", match: :first

    fill_in "Channel", with: @stock.channel_id
    fill_in "Item", with: @stock.item_id
    fill_in "Level", with: @stock.level
    fill_in "Location", with: @stock.location_id
    fill_in "Product", with: @stock.product_id
    click_on "Update Stock"

    assert_text "Stock was successfully updated"
    click_on "Back"
  end

  test "destroying a Stock" do
    visit stocks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stock was successfully destroyed"
  end
end
