require 'rails_helper'

RSpec.describe Subject, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:sections) }
  end

  describe 'validations' do
    it 'is valid with a unique name' do
      subject = FactoryBot.build(:subject)
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject = FactoryBot.build(:subject, name: nil)
      expect(subject).to_not be_valid
    end

    it 'is not valid with a duplicate name' do
      FactoryBot.create(:subject, name: 'UniqueSubject')
      subject = FactoryBot.build(:subject, name: 'UniqueSubject')
      expect(subject).to_not be_valid
    end
  end
end 