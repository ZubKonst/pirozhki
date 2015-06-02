module TestBaseBuilder

  def builder; raise 'This method must be overridden.' end
  def model; builder::MODEL end

  def test_create_record
    record_builder = builder.new @sample_data

    assert_record_count_change +1 do
      record_builder.find_or_create!
    end

    record_attrs = model.last.attributes
    expected_attrs = builder_attrs record_builder
    assert_empty expected_attrs.to_a - record_attrs.to_a
  end

  def test_not_create_same_record_twice
    assert_record_count_change +1 do
      record_builder = builder.new @sample_data
      record_builder.find_or_create!
    end

    refute_record_count_change do
      record_builder = builder.new @sample_data
      record_builder.find_or_create!
    end
  end

  def test_find_one_required_record
    @collection_data.each do |data|
      record_builder = builder.new data
      record_builder.find_or_create!
    end

    refute_record_count_change do
      record_builder = builder.new @sample_data
      record = record_builder.find_or_create!

      record_attrs = record.attributes
      expected_attrs = builder_attrs record_builder
      assert_empty expected_attrs.to_a - record_attrs.to_a
    end
  end

  private

  def builder_attrs record_builder
    hash = record_builder.attrs.stringify_keys
    hash.delete 'content_type' # Post case. content_type is enum variable
    hash.delete_if { |k, _v| k.include? '_ids' } # delete difficult relation keys
  end

  def refute_record_count_change
    assert_record_count_change 0 do
      yield
    end
  end

  def assert_record_count_change diff
    records_before = model.count
    yield
    records_after = model.count
    assert_equal diff, records_after - records_before, "Expected #{model}.count to change by #{diff}"
  end
end