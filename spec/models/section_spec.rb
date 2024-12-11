require 'rails_helper'

RSpec.describe Section, type: :model do
  let(:section) { create(:section) }
  let(:conflicting_section) { create(:section, start_time: section.start_time, end_time: section.end_time, days: section.days) }
  let(:non_conflicting_section) { create(:section, start_time: section.end_time + 1.hour, end_time: section.end_time + 2.hours, days: "TTh") }

  it "validates presence of start_time, end_time, and days" do
    expect(section).to validate_presence_of(:start_time)
    expect(section).to validate_presence_of(:end_time)
    expect(section).to validate_presence_of(:days)
  end

  it "detects conflicts with overlapping sections" do
    expect(section.conflicts_with?(conflicting_section)).to be true
  end

  it "does not detect conflicts with non-overlapping sections" do
    expect(section.conflicts_with?(non_conflicting_section)).to be false
  end
end 