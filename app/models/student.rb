class Student < ApplicationRecord
  has_many :enrollments
  has_many :sections, through: :enrollments

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  def add_section(new_section)
    if sections.none? { |section| section.conflicts_with?(new_section) }
      sections << new_section
      true
    else
      false
    end
  end
end