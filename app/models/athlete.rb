class Athlete < ApplicationRecord
  has_many :session_metrics, dependent: :destroy
  self.primary_key = "id"
  before_create { self.id ||= SecureRandom.uuid }

  has_secure_password

  validates :name, presence: true
  validates :position, presence: true
  validates :number, presence: true, numericality: { only_integer: true }

  validates :email, presence: true, uniqueness: true
end
