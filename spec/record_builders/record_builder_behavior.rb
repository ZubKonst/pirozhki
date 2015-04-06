
shared_examples 'record builder' do

  let :model do
    described_class::MODEL
  end

  subject do
    described_class.new sample_data
  end

  let :subject_attrs do
    hash = subject.attrs.stringify_keys
    hash.delete 'content_type' # Post case. content_type is enum variable
    hash.delete_if { |k, _v| k.include? '_ids' } # delete difficult relation keys
  end

  context '#find_or_create!' do
    it 'create record' do
      expect do
        subject.find_or_create!
      end.to change { model.count }.by 1

      expect(model.last.attributes).to a_hash_including subject_attrs
    end

    it 'not create same record twice' do
      subject.find_or_create!

      expect do
        subject.find_or_create!
      end.not_to change { model.count }
    end

    it 'find one required record' do
      collection_data.each do |data|
        subject_builder = described_class.new data
        subject_builder.find_or_create!
      end

      record = subject.find_or_create!
      expect(record.attributes).to a_hash_including subject_attrs
    end

    it 'solve concurrent creation problem' do
      subject.find_or_create!
      allow(model).to receive(:find_by) { nil }

      expect do
        subject.find_or_create!
      end.not_to raise_error
    end
  end

end
