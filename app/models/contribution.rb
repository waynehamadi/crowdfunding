class Contribution < ApplicationRecord
  include AASM
  belongs_to :user
  belongs_to :project
  belongs_to :counterpart
  validates :amount_in_cents, :user, :project, :counterpart, presence: true

  aasm do
    state :created, initial: true
    state :payment_pending
    state :paid
    state :canceled
    event :initialize_payment do
      transitions from: :create, to: :payment_pending
    end
    event :pay do
      transitions from: :payment_pending, to: :paid
    end
    event :cancel do
      transitions from: :payment_pending, to: :canceled
    end
  end
end

