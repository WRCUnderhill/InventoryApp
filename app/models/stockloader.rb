class Stockloader

  def load_stocks

    shopify_id = Channel.where(name: 'Shopify').ids.first
    products = Product.where(channel_id: shopify_id)
    products.each do |product| 
      product_id = Product.where(channel_product_id: product.channel_product_id, channel_id: shopify_id).ids.first
      items = Item.where(product_id: product_id, channel_id: shopify_id)
      items.each do |item|
        item_id = Item.where(channel_item_id: item.channel_item_id, product_id: product_id, channel_id: shopify_id).ids.first
        item_inv_id = item.channel_inventory_id
        locations = Location.where(channel_id: shopify_id)
        locations.each do |location|
          location_id = Location.where(channel_location_id: location.channel_location_id, channel_id: shopify_id).ids.first
          num_this_stock = Stock.where(item_id: item_id, location_id: location_id).length

          if num_this_stock == 1

            this_stock = Stock.where(item_id: item_id, location_id: location_id).first
            this_stock.level = 0

          elsif num_this_stock == 0

            this_stock = Stock.new
            this_stock.level = 0
            this_stock.item_id = item_id
            this_stock.location_id = location_id
            this_stock.product_id = product_id
            this_stock.channel_id = shopify_id

          else

              if num_this_stock.nil?
                error_text = "number of times this stock level appears is nil.  "
              elsif num_this_stock < 0
                error_text = "number of times this stock level appears is negative. "
              elsif num_this_stock > 1
                error_text = "number of times this stock level appears is greater than one. "
              else
                error_text = "number of times this stock level appears is not expected. "
              end
              error_text  = error_text + "item is ",item.channel_item_id + "location is ",location.channel_location_id,"\n"
              raise(RuntimeError, error_text)
          end

          this_stock.save
        end

        shopify_stocks = ShopifyAPI::InventoryLevel.find(:all, params: { inventory_item_id: item_inv_id })
        shopify_stocks.each do |shopify_stock|
          this_loction = Location.where(channel_loction_id: shopify_stock.location_id, channel_id: shopify_id)
          unless this_location.nonstocking
            location_id = Location.where(channel_loction_id: shopify_stock.location_id, channel_id: shopify_id).ids.first
            this_stock = Stock.where(item_id: item_id, location_id: location_id)
            this_stock.level = shopify_stock.available
            this_stock.save
          end
        end
      end
    end

  end

end
