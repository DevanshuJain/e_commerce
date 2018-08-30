class Product < ApplicationRecord
  belongs_to :seller
  has_many_attached :avatars, dependent: :destroy
  has_one :cart_product, dependent: :destroy
  has_one :cart, through: :cart_product, dependent: :destroy
end


