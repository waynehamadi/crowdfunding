class Project < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  belongs_to :category
  validates :name, presence: true
  validates :short_description, presence: true
  validates :long_description, presence: true
  validates :goal_amount, presence: true
end
