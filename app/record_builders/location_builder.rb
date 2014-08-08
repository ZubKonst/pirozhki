require_relative 'base_builder'

class LocationBuilder < BaseBuilder

  private

  def model
    Location
  end

  def uniq_attrs
    if @data['id']
      attrs.select { |key| [ :instagram_id ].include?(key) }
    else
      attrs.select { |key| [ :lat, :lng ].include?(key) }
    end
  end

  def attrs
    {
      instagram_id: @data['id'],
      lat: @data['latitude'],
      lng: @data['longitude'],
      name:      @data['name']
    }
  end
end
