require 'spec_helper'

describe Proposal do
  context 'fabricators' do
    it 'has a valid factory' do
      expect(Fabricate(:proposal)).to be_valid
    end
  end

  context 'attributes' do
    describe '#job' do
      it 'is not valid without a job' do
        expect(Fabricate.build(:proposal, job: nil)).not_to be_valid
      end
    end

    describe '#seeker' do
      it 'is not valid without a seeker' do
        expect(Fabricate.build(:proposal, seeker: nil)).not_to be_valid
      end
    end
  end
end
