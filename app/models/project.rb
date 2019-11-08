class Project < ApplicationRecord
  include ImageUploader::Attachment(:landscape_image)
  include ImageUploader::Attachment(:thumbnail_image)
  belongs_to :category
  validates :name, presence: true
  validates :goal_amount, presence: true
end
