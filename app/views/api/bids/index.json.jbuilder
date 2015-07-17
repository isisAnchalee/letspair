json.array!(@bids) do |bid|
  json.partial!('bid', bid: bid)
end

