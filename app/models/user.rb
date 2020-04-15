class User < ApplicationRecord
  # presence:true 空のデータをセーブさせない。
  validates :name, presence: true
  # uniqueness:true 同一のデータは保存させない。
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def posts
    Post.where(user_id: id)
    # return Post.where(user_id: self.id) でも同じ意。
  end

end
