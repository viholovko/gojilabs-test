require 'rails_helper'

RSpec.describe Student, type: :model do

  describe 'associations' do
    it { is_expected.to have_many(:enrollments) }
    it { is_expected.to have_many(:sections).through(:enrollments) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      student = FactoryBot.build(:student)
      expect(student).to be_valid
    end

    it 'is not valid without a name' do
      student = FactoryBot.build(:student, name: nil)
      expect(student).to_not be_valid
    end

    it 'is not valid without an email' do
      student = FactoryBot.build(:student, email: nil)
      expect(student).to_not be_valid
    end

    it 'is not valid with a duplicate email' do
      FactoryBot.create(:student, email: 'test@example.com')
      student = FactoryBot.build(:student, email: 'test@example.com')
      expect(student).to_not be_valid
    end
  end

  describe '#add_section' do
    let(:student) { FactoryBot.create(:student) }
    let(:section) { FactoryBot.create(:section) }

    context 'when there are no conflicts' do
      it 'adds the section to the student\'s schedule' do
        expect(student.add_section(section)).to be true
        expect(student.sections).to include(section)
      end
    end

    context 'when there are conflicts' do
      let(:conflicting_section) { FactoryBot.create(:section, start_time: section.start_time, end_time: section.end_time, days: section.days) }

      it 'does not add the section to the student\'s schedule' do
        student.add_section(section)
        expect(student.add_section(conflicting_section)).to be false
        expect(student.sections).to include(section)
        expect(student.sections).not_to include(conflicting_section)
      end
    end
  end

  describe '#remove_section' do
    let(:student) { FactoryBot.create(:student) }
    let(:section) { FactoryBot.create(:section) }

    it 'removes the section from the student\'s schedule' do
      student.add_section(section)
      expect {
        student.sections.delete(section)
      }.to change { student.sections.count }.by(-1)
    end
  end
end 