require 'rails_helper'

RSpec.describe Classroom, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:sections) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      classroom = FactoryBot.build(:classroom)
      expect(classroom).to be_valid
    end

    it 'is not valid without a name' do
      classroom = FactoryBot.build(:classroom, name: nil)
      expect(classroom).to_not be_valid
    end
  end
end 