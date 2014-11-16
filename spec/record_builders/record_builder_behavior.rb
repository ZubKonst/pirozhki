
shared_examples 'record builder' do

  describe '#find_or_create!' do
    it 'create record' do
      subject.new(data).find_or_create!
      expect(records.count).to eq(1)
    end

    it 'find record if exists' do
      first  = subject.new(data).find_or_create!
      second = subject.new(data).find_or_create!

      expect(records.count).to eq(1)
      expect(first.id).to eq(second.id)
    end


    it 'solve concurrent creation problem' do
      subject_instance = subject.new(data)
      subject_instance.find_or_create!
      allow(records).to receive(:find_by) { nil }

      subject_instance.find_or_create!

      expect(records.count).to eq(1)
    end
  end

end
