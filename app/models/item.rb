class Item < ApplicationRecord
  has_many :comments
  belongs_to :user
  has_many :item_images, dependent: :destroy

  accepts_nested_attributes_for :item_images
end
