class Booking < ApplicationRecord
  belongs_to :car
  belongs_to :user

  validates :start_date, uniqueness: true
  validates :end_date, uniqueness: true
end
