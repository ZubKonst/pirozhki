
shared_examples 'record builder' do

  context '#find_or_create!' do

    let :subject_instance do
      subject.new sample_data
    end
    let :subject_instance_attrs do
      hash = subject_instance.attrs.stringify_keys
      hash.delete 'content_type' # Post case. content_type is enum variable
      hash.delete_if { |k, _v| k.include? '_ids' } # delete difficult relation keys
    end

    it 'create record' do
      record = subject_instance.find_or_create!
      expect(records.count).to eq 1
      expect(record.attributes).to a_hash_including subject_instance_attrs
    end

    it 'not create same record twice' do
      first  = subject_instance.find_or_create!
      second = subject_instance.find_or_create!

      expect(records.count).to eq 1
      expect(first.id).to eq second.id
    end

    it 'find one required record' do
      collection_data.each do |data|
        subject_builder = subject.new data
        subject_builder.find_or_create!
      end

      record = subject_instance.find_or_create!
      expect(record.attributes).to a_hash_including subject_instance_attrs
    end

    it 'solve concurrent creation problem' do
      subject_instance.find_or_create!
      allow(records).to receive(:find_by) { nil }

      subject_instance.find_or_create!

      expect(records.count).to eq 1
    end
  end

end
