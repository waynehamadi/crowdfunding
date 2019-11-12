class Counterpart < ApplicationRecord
  belongs_to :project
  has_many :contributions, dependent: :destroy
  validates :amount_in_cents, presence: true
end
