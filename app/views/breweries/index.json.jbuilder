json.array!(@breweries) do |brewery|
  json.extract! brewery, :id, :name, :year, :average, :countBeers
end
