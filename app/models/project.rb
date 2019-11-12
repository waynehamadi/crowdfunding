class Project < ApplicationRecord
  include ImageUploader::Attachment(:landscape_image)
  include ImageUploader::Attachment(:thumbnail_image)
  has_many :counterparts, dependent: :destroy
  has_many :contributions, dependent: :destroy
  belongs_to :category
  validates :name, :goal_amount, presence: true

  def percent_done
    amount_contributed.to_f * 100.00 / goal_amount.to_f
  end

  def amount_contributed
    contributions.sum :amount_in_cents
  end
end
