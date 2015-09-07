require_relative 'base_builder'

class LocationBuilder < BaseBuilder
  MODEL = Location

  def attrs
    {
      instagram_id: @data['id'].to_s.presence,
      lat: @data['latitude'],
      lng: @data['longitude'],
      name: @data['name']
    }
  end

  private

  def uniq_keys
    attrs[:instagram_id] ? [:instagram_id] : [:lat, :lng]
  end
end
