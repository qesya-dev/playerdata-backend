class SessionMetric < ApplicationRecord
  self.primary_key = "id"
  before_create { self.id ||= SecureRandom.uuid }

  belongs_to :athlete
  belongs_to :training_session

  # Validations
  validates :athlete_id, presence: true
  validates :training_session_id, presence: true

  validates :distance, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :sprints, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :top_speed, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
