require 'rails_helper'

RSpec.describe Teacher, type: :model do

  describe 'associations' do
    it { is_expected.to have_many(:sections) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      teacher = FactoryBot.build(:teacher)
      expect(teacher).to be_valid
    end

    it 'is not valid without a name' do
      teacher = FactoryBot.build(:teacher, :without_name)
      expect(teacher).to_not be_valid
    end

    it 'is not valid with an invalid email' do
      teacher = FactoryBot.build(:teacher, :with_invalid_email)
      expect(teacher).to_not be_valid
    end

    it 'is not valid with a duplicate email' do
      FactoryBot.create(:teacher, email: "duplicate@example.com")
      teacher = FactoryBot.build(:teacher, email: "duplicate@example.com")
      expect(teacher).to_not be_valid
    end
  end
end 