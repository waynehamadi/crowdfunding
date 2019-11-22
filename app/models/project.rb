class Project < ApplicationRecord
  include ImageUploader::Attachment(:landscape_image)
  include ImageUploader::Attachment(:thumbnail_image)
  include AASM
  has_many :counterparts, dependent: :destroy
  has_many :contributions, dependent: :destroy
  has_many :contributors, through: :contributions, source: :user
  belongs_to :category
  validates :name, :goal_amount, presence: true
  validates :goal_amount, numericality: { greater_than: 0 }
  aasm do
    state :draft, initial: true
    state :upcoming
    state :ongoing
    state :success
    state :failure

    event :up do
      transitions from: :draft, to: :upcoming, guard: :upcoming_possible?
    end
    event :on do
      transitions from: :upcoming, to: :ongoing, guard: :ongoing_possible?
    end
    event :success do
      transitions from: :ongoing, to: :success, guard: :success_possible?
    end
    event :failure do
      transitions from: :ongoing, to: :failure, guard: :failure_possible?
    end
  end
  def self.state
    Project.aasm.states_for_select
  end

  def upcoming_possible?
    name && long_description && short_description && landscape_image_data && thumbnail_image_data && goal_amount
  end

  def ongoing_possible?
    category_id && counterparts.any?
  end

  def success_possible?
    percent_done >= 100
  end

  def failure_possible?
    !success_possible?
  end
  def percent_done
    amount_contributed.to_f * 100.00 / goal_amount.to_f
  end

  def amount_contributed
    contributions.sum :amount_in_cents
  end
end
