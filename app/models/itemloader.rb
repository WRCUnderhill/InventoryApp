class Itemloader

  def load_items

    shopify_id = Channel.where(name: 'Shopify').ids.first
    @products = Product.where(channel_id: shopify_id)
    @products.each do |product|  #  3 - loop over products begins
      product_id = Product.where(channel_product_id: product.channel_product_id, channel_id: shopify_id).ids.first
      @items = ShopifyAPI::Variant.find(:all, params: { product_id: product.channel_product_id })
      @items.each do |item|  #  4 - loop over items begins
        num_this_item = Item.where(channel_item_id: item.id, product_id: product_id, channel_id: shopify_id).length

        if num_this_item == 1
          # this is an existing item
          this_item_id = Item.where(channel_item_id: item.id, product_id: product_id, channel_id: shopify_id).ids.first
          this_item = Item.where(channel_item_id: item.id, product_id: product_id, channel_id: shopify_id).first

        elsif num_this_item == 0
          # this is a new item
          this_item = Item.new
          this_item.channel_item_id = item.id.to_s
          this_item.product_id = product_id
          this_item.channel_id = shopify_id
        else
        # the only acceptable values of num_this_item are 0 and 1
          if num_this_item.nil?
            error_text = "number of times this item appears is nil, location "
          elsif num_this_item < 0
            error_text = "number of times this item appears is negative, location "
          elsif num_this_item > 1
            error_text = "number of times this item appears is greater than one, location "
          else
            error_text = "number of times this item appears is not expected, location "
          end
          error_text  = error_text + item.id.to_s
          raise(RuntimeError, error_text)
        end
        this_item.name = item.title
        this_item.channel_inventory_id = item.inventory_item_id.to_s
        this_item.save
      end   #  4 - loop over items ends
    end   #  3 - loop over products ends
  end

end
