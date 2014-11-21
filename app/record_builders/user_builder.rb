require_relative 'base_builder'

class UserBuilder < BaseBuilder

  def attrs
    {
      instagram_id: @data['id'].to_i,
      nick_name:    @data['username'],
      full_name:    @data['full_name'],
      image:        @data['profile_picture']
    }
  end

  private

  def model
    User
  end

  def uniq_keys
    [ :instagram_id ]
  end
end
