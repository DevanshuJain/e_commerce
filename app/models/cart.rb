class Cart < ApplicationRecord
  belongs_to :order
  has_one :cart_product, dependent: :destroy
  has_one :product, through: :cart_product, dependent: :destroy
end
