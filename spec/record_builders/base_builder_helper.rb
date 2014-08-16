module BaseBuilderHelper
  extend ActiveSupport::Concern

  included do
    describe '#find_or_create!' do
      it 'create record' do
        subject.new(data).find_or_create!
        records.count.must_equal 1
      end

      it 'find record if exists' do
        first  = subject.new(data).find_or_create!
        second = subject.new(data).find_or_create!

        records.count.must_equal 1
        first.id.must_equal second.id
      end


      it 'solve concurrent creation problem' do
        subject_instance = subject.new(data)
        subject_instance.find_or_create!

        records.stub :find_by, nil do
          subject_instance.find_or_create!
          records.count.must_equal 1
        end
      end
    end
  end
end
