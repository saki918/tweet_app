class User < ApplicationRecord
  # has_secure_password メソッドはGemfileに gem "bcrypt"を記述する事で使えるようになる。
  # has_secure_password メソッドで、passwordは空の状態で登録されるとバリデーションで引っかかる。
  has_secure_password
  # presence:true 空のデータをセーブさせない。
  validates :name, presence: true
  # uniqueness:true 同一のデータは保存させない。
  validates :email, presence: true, uniqueness: true
  # ⬇︎has_secure_password で空のパスワードは保存されないので、削除しても良い。
  # validates :password, presence: true

  def posts
    Post.where(user_id: id)
    # return Post.where(user_id: self.id) でも同じ意。
  end

end
