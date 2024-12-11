require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe 'associations' do
    it { should belong_to(:student) }
    it { should belong_to(:section) }
  
    it 'belongs to a student' do
      enrollment = FactoryBot.build(:enrollment)
      expect(enrollment.student).to be_a(Student)
    end

    it 'belongs to a section' do
      enrollment = FactoryBot.build(:enrollment)
      expect(enrollment.section).to be_a(Section)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      enrollment = FactoryBot.build(:enrollment)
      expect(enrollment).to be_valid
    end

    it 'is not valid without a student' do
      enrollment = FactoryBot.build(:enrollment, student: nil)
      expect(enrollment).to_not be_valid
    end

    it 'is not valid without a section' do
      enrollment = FactoryBot.build(:enrollment, section: nil)
      expect(enrollment).to_not be_valid
    end
  end
end 