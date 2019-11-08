class Contribution < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :counterpart
  validates :amount_in_cents, :user, :project, :counterpart, presence: true
end

