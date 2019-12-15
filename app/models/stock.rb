class Stock < ApplicationRecord
  belongs_to :item
  belongs_to :location
  belongs_to :product
  belongs_to :channel
end
