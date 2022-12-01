class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :photos
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  include PgSearch::Model
    pg_search_scope :search_by_brand_and_model_and_location,
      against: [ :brand, :model, :location ],
      using: {
        tsearch: { prefix: true }
      }
end
