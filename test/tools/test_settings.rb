require_relative '../test_helper'

class TestSettings < Minitest::Test

  def setup
    @instagram_settings = Settings.instagram
  end

  def test_instagram_defaults
    assert_equal 0, @instagram_settings.request_delay
  end
end
