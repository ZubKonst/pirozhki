require_relative 'base_builder'

class LocationBuilder < BaseBuilder

  def attrs
    {
      instagram_id: @data['id'],
      lat: @data['latitude'],
      lng: @data['longitude'],
      name: @data['name']
    }
  end

  private

  def model
    Location
  end

  def uniq_keys
    attrs[:instagram_id] ? [:instagram_id] : [:lat, :lng]
  end
end
