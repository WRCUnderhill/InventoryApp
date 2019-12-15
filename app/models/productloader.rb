class Productloader

  def load_products
    #get the id of the channel that is Shopify
    shopify_id = Channel.where(name: 'Shopify').ids.first
    @products = ShopifyAPI::Product.find(:all)
    @products.each do |prod|
      num_this_prod = Product.where(channel_product_id: prod.id, channel_id: shopify_id).length

      if num_this_prod == 1
        # this is an existing product
        this_prod = Product.where(channel_product_id: prod.id, channel_id: shopify_id).first

      elsif num_this_prod == 0
        # this is a new product
        this_prod = Product.new
        this_prod.channel_product_id = prod.id.to_s
        this_prod.channel_id = shopify_id
      else
        # the only acceptable values of num_this_prod are 0 and 1
        if num_this_prod.nil?
          error_text = "number of times this product appears is nil, product "
        elsif num_such_stocks < 0
          error_text = "number of times this product appears is negative, product "
        elsif num_such_stocks > 1
          error_text = "number of times this product appears is greater than one, product "
        else
          error_text = "number of times this product appears is not expected, product "
        end
        error_text  = error_text + prod.id.to_s
        raise(RuntimeError, error_text)
      end
      this_prod.name = prod.title
      this_prod.label_1 = prod.product_type
      this_prod.save
    end
  end
end
