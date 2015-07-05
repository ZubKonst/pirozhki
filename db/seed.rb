require_relative '../app'

# Toronto, ON.
coordinates =
  [
    {:lat=>43.57, :lng=>-79.64}, {:lat=>43.57, :lng=>-79.46}, {:lat=>43.57, :lng=>-79.29}, {:lat=>43.57, :lng=>-79.11},
    {:lat=>43.62, :lng=>-79.55}, {:lat=>43.62, :lng=>-79.38}, {:lat=>43.62, :lng=>-79.20},
    {:lat=>43.67, :lng=>-79.64}, {:lat=>43.67, :lng=>-79.46}, {:lat=>43.67, :lng=>-79.29}, {:lat=>43.67, :lng=>-79.11},
    {:lat=>43.71, :lng=>-79.55}, {:lat=>43.71, :lng=>-79.38}, {:lat=>43.71, :lng=>-79.20},
    {:lat=>43.76, :lng=>-79.64}, {:lat=>43.76, :lng=>-79.46}, {:lat=>43.76, :lng=>-79.29}, {:lat=>43.76, :lng=>-79.11},
    {:lat=>43.81, :lng=>-79.55}, {:lat=>43.81, :lng=>-79.38}, {:lat=>43.81, :lng=>-79.20},
    {:lat=>43.86, :lng=>-79.64}, {:lat=>43.86, :lng=>-79.46}, {:lat=>43.86, :lng=>-79.29}, {:lat=>43.86, :lng=>-79.11},
  ]
hashtags = [
  tag_name: 'canada',
  tag_name: 'ontario',
  tag_name: 'toronto',
]

p 'Before seeding:'
p "#{Source::GeoPoint.count} geo_points,"
p "#{Source::Hashtag.count} hashtags."

coordinates.each do |coordinate|
  Source::GeoPoint.find_or_create_by! coordinate
end
hashtags.each do |hashtag|
  Source::Hashtag.find_or_create_by! hashtag
end

p 'After seeding:'
p "#{Source::GeoPoint.count} geo_points,"
p "#{Source::Hashtag.count} hashtags."
