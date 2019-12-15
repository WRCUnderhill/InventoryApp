class Locationloader

  def load_locations
    #get the id of the channel that is Shopify
    shopify_id = Channel.where(name: 'Shopify').ids.first
    @locations = ShopifyAPI::Location.find(:all)
    @locations.each do |location|
      num_this_loc = Location.where(channel_location_id: location.id, channel_id: shopify_id).length

      if num_this_loc == 1
        # this is an existing location
        this_loc = Location.where(channel_location_id: location.id, channel_id: shopify_id).first

      elsif num_this_loc == 0
        # this is a new location
        this_loc = Location.new
        this_loc.channel_location_id = location.id.to_s
        this_loc.channel_id = shopify_id

      else
        # the only acceptable values of num_this_prod are 0 and 1
        if num_this_loc.nil?
          error_text = "number of times this location appears is nil, location "
        elsif num_this_loc < 0
          error_text = "number of times this location appears is negative, location "
        elsif num_this_loc > 1
          error_text = "number of times this location appears is greater than one, location "
        else
          error_text = "number of times this location appears is not expected, location "
        end
        error_text  = error_text + location.id.to_s
        raise(RuntimeError, error_text)
      end
      this_loc.name = location.name
      this_loc.city = location.city
      this_loc.country = location.country_code
      if location.name == 'Oberlo'
        this_loc.nonstocking = true
      else
        this_loc.nonstocking = false
      end
      this_loc.save
    end
  end
end
