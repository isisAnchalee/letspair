json.extract! bid, :price, :bidder_id, :content, :created_at, :updated_at
json.bid_time_ago time_ago_in_words(bid.created_at)

json.bidders bid.bidder do |bidder|
  json.id bidder.id
end
