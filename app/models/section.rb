class Section < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject
  belongs_to :classroom
  has_many :enrollments
  has_many :students, through: :enrollments

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :days, presence: true

  def conflicts_with?(other_section)
    overlapping_days = (days.chars & other_section.days.chars).any?
    overlapping_times = (start_time...end_time).overlaps?(other_section.start_time...other_section.end_time)
    overlapping_days && overlapping_times
  end
end
