# CROSS CHANNEL INVENTORY DISPLAY AND VALUE MAP

The proposed business purpose is to help the merchant by making it easy to see
where money is tied up in inventory across multiple channels.  The merchant can
use this app on their Shopify store even if not all the channels as integrated
into the Shopify system.  Channels could be eCommerce, bricks and mortar stores,
making (in which case the items are used as parts or ingredients instead of
being for sale), a channel could be defined for short selling where the two
columns represent the date by which a contract must be fulfilled.

There would be an API based way to gather information from Shopify
There could, in future, be similar API based integrations for other eCommerce
platforms.  There could also be manual channels where the merchant would have
enter the information by hand or by CSV file.  

Once the information is drawn into the app, it would display the result as a
table, where columns represent locations  and rows represent the items.  The
top row would name the locations and the total of the value of the inventory
at that location.  The left most column would give identify the item and the
total value of that item across all locations

|            |Shopify      | other channel 1| other channel n|
|------------|:-----------:|:--------------:|:--------------:|
|            | total value |  total value   |   total value  |
|item 1 total value  |  quantity   |    quantity    |    quantity    |
| |             |                |                |
|item n total value  |  quantity   |    quantity    |    quantity    |
| |             |                |                |

In a more advanced version, it would be possible select which of these are
displayed.

In the current version, only the Shopify channel has been coded.  It relies on
the ShopifyAPI to gather information.  


## THE DATA

The database keeps a summary of the salient data for each channel.  This is a
small subset of the data maintained by Shopify.  The database is not meant to
be a replacement for the Shopify database.  It provides only a small function:
tracking inventory and the associated value and making that visible.  

Because the data may be gathered at different times for different sources, this
restricted set of data is stored in the app database.  It is updated each time
the merchant invokes the app (for that channel).  

It is assumed that each channel has its own way of organizing the data and its
own data formats.  So most data is kept as strings.  Ids may be integers for
one channel or floats for another or strings for another.  They are all
converted to strings within the app.  The data kept is

Channel: 
* only the name of the channel.

Product: 
* name - a descriptive string  
* id - the id used by the channel for the product (string)  
* channel_id - foreign key - the id of the channel to which this product belongs.

Location: 
* name - a descriptive string
* id - the id used by the channel for the location (string)
* city - string
* country - 2 letter code
* channel_id - foreign key - the id of the channel to which this location belongs.

Item:     
* name - a descriptive string
* price - unit price (string)
* inventory code - some channels keep separate product and inventory codes for items (string)
* product_id - foreign key - the id of the product to which this item belongs.
* channel_id - foreign key - the id of the channel to which this item belongs.

Stock:  The count of a particular kind of item at a particular location
* level - integer - count of a particular kind of item at a particular location
* item_id - foreign key - the id of the item to which this stock belongs.
* location_id - foreign key - the id of the loction to which this item belongs.
* product_id - foreign key - the id of the product to which this item belongs.  Not strictly necessary, but included for convenience
* channel_id - foreign key - the id of the channel to which this item belongs.  Not strictly necessary, but included for convenience

Stock Link: Gathering (find all) will allow calculation of aggregate quantities for the same item across channels
* item_id - foreign key - the id of the item which is sold across channels
* product_id - foreign key - the id of the product of the items which is sold across channels
* channel_id - foreign key - the id of the channel of the item which is sold across channels

Location Link: Gathering (find all) will allow calculation of aggregate quantities for the same item across channels
* loction_id - foreign key - the id of the location used across channels
* channel_id - foreign key - the id of the channel which uses the location.

This is the key data needed to calculate the display of how the stock is
distributed across the merchant's locations and channels
