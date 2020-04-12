class User < ApplicationRecord
  # presence:true 空のデータをセーブさせない。
  validates :name, presence: true
  # uniqueness:true 同一のデータは保存させない。
  validates :email, presence: true, uniqueness: true
end
