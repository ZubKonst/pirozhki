def coordinates sw, ne, n_lat, n_lng
  start_lat = sw[:lat]
  end_lat = ne[:lat]
  diff_lat = end_lat - start_lat
  period_lat = diff_lat/n_lat

  start_lng = sw[:lng]
  end_lng = ne[:lng]
  diff_lng = end_lng - start_lng
  period_lng = diff_lng/n_lat

  out = []
  (n_lat+1).times.each do |i_lat|
    (n_lng+1).times.each do |i_lng|
      current_lat = start_lat + i_lat * period_lat
      current_lng = start_lng + i_lng * period_lng
      out << { lat: current_lat, lng: current_lng }
    end
  end

  n_lat.times.each do |i_lat|
    n_lng.times.each do |i_lng|
      current_lat = start_lat + i_lat * period_lat + period_lat/2
      current_lng = start_lng + i_lng * period_lng + period_lng/2
      out << { lat: current_lat, lng: current_lng }
    end
  end

  out
end


# Moscow:
sw = { lat: 55.489927, lng: 37.3193288 }
ne = { lat: 56.009657, lng: 37.9456611 }

# Toronto:
sw = { lat: 43.57, lng: -79.64 }
ne = { lat: 43.86, lng: -79.11 }


a = Geokit::LatLng.new sw[:lat],sw[:lng]
b = Geokit::LatLng.new ne[:lat],ne[:lng]
a.distance_to b # 33.2km - SW to NE

a = Geokit::LatLng.new sw[:lat],sw[:lng]
b = Geokit::LatLng.new sw[:lat],ne[:lng]
a.distance_to b # 26.6km - W to E

a = Geokit::LatLng.new sw[:lat],sw[:lng]
b = Geokit::LatLng.new ne[:lat],sw[:lng]
a.distance_to b # 20km - N to S

coordinates sw, ne, 3, 3

[
  {:lat=>43.57, :lng=>-79.64}, {:lat=>43.57, :lng=>-79.46}, {:lat=>43.57, :lng=>-79.29}, {:lat=>43.57, :lng=>-79.11},
  {:lat=>43.62, :lng=>-79.55}, {:lat=>43.62, :lng=>-79.38}, {:lat=>43.62, :lng=>-79.20},
  {:lat=>43.67, :lng=>-79.64}, {:lat=>43.67, :lng=>-79.46}, {:lat=>43.67, :lng=>-79.29}, {:lat=>43.67, :lng=>-79.11},
  {:lat=>43.71, :lng=>-79.55}, {:lat=>43.71, :lng=>-79.38}, {:lat=>43.71, :lng=>-79.20},
  {:lat=>43.76, :lng=>-79.64}, {:lat=>43.76, :lng=>-79.46}, {:lat=>43.76, :lng=>-79.29}, {:lat=>43.76, :lng=>-79.11},
  {:lat=>43.81, :lng=>-79.55}, {:lat=>43.81, :lng=>-79.38}, {:lat=>43.81, :lng=>-79.20},
  {:lat=>43.86, :lng=>-79.64}, {:lat=>43.86, :lng=>-79.46}, {:lat=>43.86, :lng=>-79.29}, {:lat=>43.86, :lng=>-79.11},
]
