class Order < ApplicationRecord
  belongs_to :user
  has_many :carts, dependent: :destroy
  scope :placed, -> { find_by(status: false) }
end
