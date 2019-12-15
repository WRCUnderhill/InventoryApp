# frozen_string_literal: true

class HomeController < AuthenticatedController
  def index

    Productloader.new.load_products
    @db_products = Product.all


    Locationloader.new.load_locations
    @db_locations = Location.all

    Itemloader.new.load_items
    @db_items = Item.all

    Stockloader.new.load_stocks
    @db_stocks = Stock.all

  end
end
