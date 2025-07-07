class TrainingSession < ApplicationRecord
  self.primary_key = "id"
  before_create { self.id ||= SecureRandom.uuid }

  has_many :session_metrics, dependent: :destroy

  # Validations
  validates :name, presence: true, length: { minimum: 2 }
  validates :date, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
